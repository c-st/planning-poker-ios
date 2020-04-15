//
//  Store.swift
//  PlanningPoker
//
//  Created by Edward Byne on 16/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Combine
import Foundation
import Starscream

struct Participant: Identifiable {
    var id: UUID = UUID()
    var name: String
    var hasEstimated = false
    var isSpectator = false
}

struct JoinRoomData {
    var roomName = ""
    var participantName = ""
    var isSpectator = false
    var isShowCats = true
}

protocol StoreProtocol {
    func joinRoom(_ roomData: JoinRoomData)
    func rejoinRoom()
    func leaveRoom()
    func sendStartEstimationRequestFor(_ newTaskName: String)
    func sendEstimate(_ estimate: String)
    func sendEstimationResultRequest()
}

final class Store: StoreProtocol, ObservableObject {
    @Published var state: AppState

    // TODO: see how Combine can be used to handle name/room state

    private var socketClient: SocketClient?
    private let decoder = JSONDecoder()

    init(_ initialState: AppState = AppState()) {
        self.state = initialState
    }

    func joinRoom(_ roomData: JoinRoomData) {
        self.state.roomName = roomData.roomName
        self.state.participant = Participant(name: roomData.participantName, isSpectator: roomData.isSpectator)
        self.state.isShowCats = roomData.isShowCats

        self.socketClient = SocketClient(
            handleEvent: { event in
                self.state = EventHandler.handle(event, state: self.state)
            },
            onConnect: {
                let joinRoomEvent = JoinRoom(
                    userName: roomData.participantName,
                    roomName: roomData.roomName,
                    isSpectator: roomData.isSpectator
                )
                self.socketClient!.send(joinRoomEvent)
                print("oh hai", joinRoomEvent)
            }
        )

        if let socketClient = self.socketClient {
            socketClient.connect()
        }
    }

    func rejoinRoom() {
        if UITestingUtils.isInUITest {
            return
        }

        if let participant = self.state.participant, let roomName = self.state.roomName {
            self.state = AppState(
                participant: Participant(
                    id: participant.id,
                    name: participant.name,
                    hasEstimated: false
                ),
                roomName: roomName,
                isShowCats: self.state.isShowCats
            )

            if let socketClient = self.socketClient {
                socketClient.connect()
            }
        }
    }

    func leaveRoom() {
        self.state = AppState()

        if let socketClient = self.socketClient {
            socketClient.disconnect()
        }
    }

    func sendStartEstimationRequestFor(_ newTaskName: String) {
        let requestStartEstimationEvent = RequestStartEstimation(
            userName: state.participant!.name,
            taskName: newTaskName,
            startDate: Date()
        )

        if let socketClient = self.socketClient {
            socketClient.send(requestStartEstimationEvent)
        }
    }

    func sendEstimate(_ estimate: String) {
        let ourName = self.state.participant!.name
        self.state.participant = Participant(
            name: ourName,
            hasEstimated: true
        )

        self.state.estimations[ourName] = estimate

        let estimationEvent = UserEstimate(
            userName: state.participant!.name,
            taskName: self.state.currentTaskName!,
            estimate: estimate
        )

        if let socketClient = self.socketClient {
            socketClient.send(estimationEvent)
        }
    }

    func sendEstimationResultRequest() {
        let event = RequestShowEstimationResult(
            userName: state.participant!.name
        )

        if let socketClient = self.socketClient {
            socketClient.send(event)
        }
    }
}
