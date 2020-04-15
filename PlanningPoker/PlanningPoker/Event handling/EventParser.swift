//
//  EventParser.swift
//  PlanningPoker
//
//  Created by Edward Byne on 17/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation

final class EventParser {
    static func parse(_ jsonString: String) -> Any? {
        let jsonData = jsonString.data(using: .utf8)!
        let baseEvent = try! JSON.decoder.decode(BaseEvent.self, from: jsonData)

        switch baseEvent.eventType {
            case .joinRoom:
                return try? JSON.decoder.decode(JoinRoom.self, from: jsonData)
            case .userJoined:
                return try? JSON.decoder.decode(UserJoined.self, from: jsonData)
            case .userLeft:
                return try? JSON.decoder.decode(UserLeft.self, from: jsonData)
            case .startEstimation:
                return try? JSON.decoder.decode(RequestStartEstimation.self, from: jsonData)
            case .estimate:
                return try? JSON.decoder.decode(UserEstimate.self, from: jsonData)
            case .userHasEstimated:
                return try? JSON.decoder.decode(UserHasEstimated.self, from: jsonData)
            case .showResult:
                return try? JSON.decoder.decode(RequestShowEstimationResult.self, from: jsonData)
            case .estimationResult:
                return try? JSON.decoder.decode(EstimationResult.self, from: jsonData)
            case .keepAlive:
                return try? JSON.decoder.decode(HeartBeat.self, from: jsonData)
        }
    }

    static func serialize(_ event: Encodable) -> String {
        let dictionary = event.dictionary
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        return String(decoding: data, as: UTF8.self)
    }
}

struct JSON {
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601WithTimezone)
        return encoder
    }()

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601WithTimezone)
        return decoder
    }()
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }

    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
