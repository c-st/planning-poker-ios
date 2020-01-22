//
//  Events.swift
//  PlanningPoker
//
//  Created by Edward Byne on 16/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation

enum EventType: String, Codable {
    case userJoined
    case userLeft
    case startEstimation
    case estimate
    case userHasEstimated
    case showResult
    case estimationResult
    case keepAlive
}

struct BaseEvent: Codable {
    let eventType: EventType
}

struct UserJoined: Codable {
    let userName: String
    let isSpectator: Bool
}

struct UserLeft: Codable {
    let userName: String
}

struct RequestStartEstimation: Codable {
    let userName: String
    let taskName: String
    let startDate: Date
    let eventType = EventType.startEstimation
}

struct UserEstimate: Codable {
    let userName: String
    let taskName: String
    let estimate: String
    let eventType = EventType.estimate
}

struct UserHasEstimated: Codable {
    let userName: String
    let taskName: String
}

struct RequestShowEstimationResult: Codable {
    let userName: String
    let eventType = EventType.showResult
}

struct EstimationResult: Codable {
    let taskName: String
    let startDate: Date
    let endDate: Date
    let estimates: [UserEstimation]
}

struct HeartBeat: Codable {
}

struct UserEstimation: Codable {
    let userName: String
    let estimate: String
}
