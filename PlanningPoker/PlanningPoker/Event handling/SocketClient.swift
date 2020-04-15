//
//  SocketClient.swift
//  PlanningPoker
//
//  Created by Edward Byne on 14/02/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation
import Starscream

final class SocketClient: WebSocketDelegate {
    let endpoint = "wss://api.planningpoker.cc/dev"

    let handleEvent: (Any) -> Void
    let onConnect: () -> Void

    private var socket: WebSocket?

    init(handleEvent: @escaping (Any) -> Void, onConnect: @escaping () -> Void) {
        self.handleEvent = handleEvent
        self.onConnect = onConnect
    }

    func connect() {
        if UITestingUtils.isInUITest {
            return
        }

        let socket = WebSocket(request: URLRequest(url: URL(string: endpoint)!))
        socket.delegate = self
        socket.connect()
        self.socket = socket
    }

    func send(_ event: Encodable) {
        if let socket = self.socket {
            socket.write(string: EventParser.serialize(event))
        }
    }

    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .text(let jsonString):
            if let parsedEvent = EventParser.parse(jsonString) {
                self.handleEvent(parsedEvent)
            } else {
                print("Event could not be parsed: \(jsonString)")
            }

        case .connected:
            self.onConnect()

        default:
            print("Not handling event: \(event)")
        }
    }

    func disconnect() {
        if let socket = self.socket {
            socket.disconnect()
        }
    }
}
