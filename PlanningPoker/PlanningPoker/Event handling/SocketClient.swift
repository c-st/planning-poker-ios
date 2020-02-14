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
    
    let handleEvent: (Any) -> Void
    
    private var socket: WebSocket?
    
    init(handleEvent: @escaping (Any) -> Void) {
        self.handleEvent = handleEvent
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .text(let jsonString):
            if let parsedEvent = EventParser.parse(jsonString) {
                self.handleEvent(parsedEvent)
            } else {
                print("Event could not be parsed: \(jsonString)")
            }
        default:
            print("Not handling event: \(event)")
        }
    }
    
    func send(_ event: Encodable) {
        if let socket = self.socket {
            socket.write(string: EventParser.serialize(event))
        }
    }

    func connect(roomName: String, participant: Participant) {
        if UITestingUtils.isInUITest {
            return
        }

        let urlString = self.buildURL(
            roomName: roomName,
            participant: participant
        )

        let socket = WebSocket(request: URLRequest(url: URL(string: urlString)!))

        socket.delegate = self
        socket.connect()

        self.socket = socket
    }
    
    func disconnect() {
        if let socket = self.socket {
            socket.disconnect()
        }
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
