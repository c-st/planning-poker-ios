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
    @Published var participants: [Participant] = []

    // TODO: see how Combine can be used to handle name/room state

    private var socket: WebSocket?

    private let decoder = JSONDecoder()

    func joinRoom(_ roomName: String, participantName: String) {
        socket = WebSocket(request: URLRequest(url: URL(
            string: "wss://planningpoker.cc/poker/\(roomName)?name=\(participantName)&spectator=False"
        )!))
        socket!.delegate = self
        socket!.connect()

        print("connected", socket)
    }

    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print("didReceive", event)

        switch event {
        case .text(let jsonString):
            let jsonData = jsonString.data(using: .utf8)!
            let baseEvent = try! decoder.decode(Event.self, from: jsonData)
            print("event type: \(baseEvent)")

            switch baseEvent.eventType {
            case .userJoined:
                let userJoinedEvent = try! decoder.decode(UserJoined.self, from: jsonData)
                participants.append(.init(id: .init(), name: userJoinedEvent.userName))
                print("Updated participants: \(participants)")
            case .userLeft:
                let userLeftEvent = try! decoder.decode(UserLeft.self, from: jsonData)
                participants = participants.filter { p in
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
