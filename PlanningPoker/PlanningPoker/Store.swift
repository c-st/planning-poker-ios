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

final class Store: ObservableObject, WebSocketDelegate {
    @Published var state: AppState = AppState()

    // TODO: see how Combine can be used to handle name/room state

    private var socket: WebSocket?

    private let decoder = JSONDecoder()

    func joinRoom(_ roomName: String, participantName: String) {
        self.state.participantName = participantName
        self.state.roomName = roomName

        let socketUrl = "wss://planningpoker.cc/poker/\(roomName)?name=\(participantName)&spectator=False"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let socket = WebSocket(request: URLRequest(url: URL(string: socketUrl)!))

        socket.delegate = self
        socket.connect()

        self.socket = socket
    }

    func leaveRoom() {
        if let socket = self.socket {
            print("User left room. Disconnecting socket")
            socket.disconnect()
        }
    }

    func sendStartEstimationRequestFor(_ newTaskName: String) {
        let requestStartEstimationEvent = RequestStartEstimation(
            userName: state.participantName!,
            taskName: newTaskName,
            startDate: Date()
        )

        if let socket = self.socket {
            socket.write(string: EventParser.serialize(requestStartEstimationEvent))
        }
    }

    func sendEstimate(_ estimate: String) {
        let estimationEvent = UserEstimate(
            userName: state.participantName!,
            taskName: self.state.currentTaskName!,
            estimate: estimate
        )
        
        if let socket = self.socket {
            socket.write(string: EventParser.serialize(estimationEvent))
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
