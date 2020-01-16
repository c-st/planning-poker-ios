//
//  Events.swift
//  PlanningPoker
//
//  Created by Edward Byne on 16/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

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

struct Event: Codable {
    var eventType: EventType
}

struct UserJoined: Codable {
    var userName: String
    var isSpectator: Bool
}

struct UserLeft: Codable {
    var userName: String
}

struct RequestStartEstimation: Codable {
    var userName: String
    var taskName: String
    var startDate: String
}

struct UserEstimate: Codable {
    var userName: String
    var taskName: String
    var estimate: String
}

struct UserHasEstimated: Codable {
    var userName: String
    var taskName: String
}

struct RequestShowEstimationResult: Codable {
    var userName: String
}

struct EstimationResult: Codable {
    var taskName: String
    var startDate: String
    var endDate: String
    var estimates: [UserEstimation]
}

struct HeartBeat: Codable {
}

struct UserEstimation: Codable {
    var userName: String
    var estimate: String
}
