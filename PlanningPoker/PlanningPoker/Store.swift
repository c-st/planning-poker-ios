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
    var id: UUID
    var name: String
}

final class Store: ObservableObject, WebSocketDelegate {
    @Published var otherParticipants: [Participant] = []

    // TODO: see how Combine can be used to handle name/room state

    private var socket: WebSocket?

    private let decoder = JSONDecoder()

    func joinRoom(_ roomName: String, participantName: String) {
        let socket = WebSocket(request: URLRequest(url: URL(
            string: "wss://planningpoker.cc/poker/\(roomName)?name=\(participantName)&spectator=False"
        )!))
        
        socket.delegate = self
        socket.connect()
        
        self.socket = socket
    }

    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print("didReceive", event)

        switch event {
        case .text(let jsonString):
            let jsonData = jsonString.data(using: .utf8)!
            let baseEvent = try! decoder.decode(BaseEvent.self, from: jsonData)
            print("event type: \(baseEvent)")

            switch baseEvent.eventType {
            case .userJoined:
                let userJoinedEvent = try! decoder.decode(UserJoined.self, from: jsonData)
                otherParticipants.append(.init(id: .init(), name: userJoinedEvent.userName))
                print("Updated participants: \(otherParticipants)")
            case .userLeft:
                let userLeftEvent = try! decoder.decode(UserLeft.self, from: jsonData)
                otherParticipants = otherParticipants.filter { p in
                    p.name != userLeftEvent.userName
                }
//                case .startEstimation:
//                    print("Not handling event: \(event)")
//                case .estimate:
//                    print("Not handling event: \(event)")
//                case .userHasEstimated:
//                    print("Not handling event: \(event)")
//                case .showResult:
//                    print("Not handling event: \(event)")
//                case .estimationResult:
//                    print("Not handling event: \(event)")
//                case .keepAlive:
//                    print("Not handling event: \(event)")
            default:
                return
            }
        default:
            print("Not handling event: \(event)")
        }
    }
}
