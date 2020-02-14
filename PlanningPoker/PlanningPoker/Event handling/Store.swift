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

final class Store: StoreProtocol, ObservableObject, WebSocketDelegate {
    @Published var state: AppState

    // TODO: see how Combine can be used to handle name/room state

    private var socket: WebSocket?
    private let decoder = JSONDecoder()

    init(_ initialState: AppState = AppState()) {
        self.state = initialState
    }

    func joinRoom(_ roomData: JoinRoomData) {
        self.state.roomName = roomData.roomName
        self.state.participant = Participant(name: roomData.participantName, isSpectator: roomData.isSpectator)
        self.state.isShowCats = roomData.isShowCats

        self.establishWebSocketConnection()
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

            self.establishWebSocketConnection()
        }
    }

    func leaveRoom() {
        self.state = AppState()

        if let socket = self.socket {
            socket.disconnect()
        }
    }

    func sendStartEstimationRequestFor(_ newTaskName: String) {
        let requestStartEstimationEvent = RequestStartEstimation(
            userName: state.participant!.name,
            taskName: newTaskName,
            startDate: Date()
        )

        if let socket = self.socket {
            socket.write(string: EventParser.serialize(requestStartEstimationEvent))
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

        if let socket = self.socket {
            socket.write(string: EventParser.serialize(estimationEvent))
        }
    }

    func sendEstimationResultRequest() {
        let event = RequestShowEstimationResult(
            userName: state.participant!.name
        )

        if let socket = self.socket {
            socket.write(string: EventParser.serialize(event))
        }
    }

    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .text(let jsonString):
            if let parsedEvent = EventParser.parse(jsonString) {
                self.state = EventHandler.handle(parsedEvent, state: self.state)
            } else {
                print("Event could not be parsed: \(jsonString)")
            }
        default:
            print("Not handling event: \(event)")
        }
    }

    private func establishWebSocketConnection() {
        if UITestingUtils.isInUITest {
            return
        }

        let urlString = buildURL(
            roomName: self.state.roomName!,
            participant: self.state.participant!
        )
    
        let socket = WebSocket(request: URLRequest(url: URL(string: urlString)!))

        socket.delegate = self
        socket.connect()

        self.socket = socket
    }
    
    private func buildURL(roomName: String, participant: Participant) -> String {
        var url = URLComponents()
        
        url.scheme = "wss"
        url.host = "planningpoker.cc"
        url.path = "/poker/\(roomName)"
        url.queryItems = [
            URLQueryItem(name: "name", value: participant.name),
            URLQueryItem(name: "spectator", value: participant.isSpectator ? "true" : "false")
        ]
        
        return url
            .url!
            .absoluteString
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
