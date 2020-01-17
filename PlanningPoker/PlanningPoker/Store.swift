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
    
    private let socket: WebSocket

    private let decoder = JSONDecoder()

    init() {
        self.socket = WebSocket(request: URLRequest(url: URL(
            string: "wss://planningpoker.cc/poker/cc-hh-test?name=Foobar&spectator=False"
        )!))
        self.socket.delegate = self
        self.socket.connect()

        print("connected", self.socket)
    }
    
//    func establishCon(roomName: String, partN: String)

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
                case .userLeft:
                    let userLeftEvent = try! decoder.decode(UserLeft.self, from: jsonData)
                    participants = participants.filter { p in
                        p.name != userLeftEvent.userName
                    }
                case .startEstimation:
                    print("Not handling event: \(event)")
                case .estimate:
                    print("Not handling event: \(event)")
                case .userHasEstimated:
                    print("Not handling event: \(event)")
                case .showResult:
                    print("Not handling event: \(event)")
                case .estimationResult:
                    print("Not handling event: \(event)")
                case .keepAlive:
                    print("Not handling event: \(event)")
            }
            default:
                print("Not handling event: \(event)")
        }
    }
}
