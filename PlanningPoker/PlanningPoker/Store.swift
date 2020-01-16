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
    @Published var participants: [Participant] = [
        .init(id: .init(), name: "Ed"),
        .init(id: .init(), name: "Christian"),
        .init(id: .init(), name: "Johannes"),
        .init(id: .init(), name: "Peppa Pig")
    ]

    private let socket: WebSocket

    init() {
        self.socket = WebSocket(request: URLRequest(url: URL(
            string: "wss://planningpoker.cc/poker/cc-hh-test?name=Foobar&spectator=False"
        )!))
        self.socket.delegate = self
        self.socket.connect()
        
        print("connected", self.socket)
    }

    func didReceive(event: WebSocketEvent, client: WebSocket) {
        //
        print("didReceive", event)
    }
}
