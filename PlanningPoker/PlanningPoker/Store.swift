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

public struct AppState {
    var estimationStatus: EstimationStatus = .notStarted
    var participant: Participant?
    var otherParticipants: [Participant] = []
    var roomName: String?
    var currentTaskName: String?
    var estimationStart: Date?

    enum EstimationStatus {
        case notStarted
        case inProgress
        case ended
    }
}

struct Participant: Identifiable {
    var id: UUID = UUID()
    var name: String
    var hasEstimated: Bool = false
    var currentEstimate: String?
}

struct JoinRoomData {
    var roomName: String = ""
    var participantName: String = ""
}

final class Store: ObservableObject, WebSocketDelegate {
    @Published var state: AppState = AppState()
    
    // TODO: see how Combine can be used to handle name/room state

    private var socket: WebSocket?
    private let decoder = JSONDecoder()

    func joinRoom(_ roomData: JoinRoomData) {
        self.state.roomName = roomData.roomName
        self.state.participant = Participant(name: roomData.participantName)

        let socketUrl = "wss://planningpoker.cc/poker/\(self.state.roomName!)?name=\(self.state.participant!.name)&spectator=False"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let socket = WebSocket(request: URLRequest(url: URL(string: socketUrl)!))

        socket.delegate = self
        socket.connect()

        self.socket = socket
    }

    func leaveRoom() {
        self.state = AppState()
        
        if let socket = self.socket {
            print("User left room. Disconnecting socket")
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
        self.state.participant = Participant(
            name: self.state.participant!.name,
            hasEstimated: true,
            currentEstimate: estimate
        )
        
        let estimationEvent = UserEstimate(
            userName: state.participant!.name,
            taskName: self.state.currentTaskName!,
            estimate: estimate
        )
        
        print("Set estimate to \(estimate)")
        
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
}
