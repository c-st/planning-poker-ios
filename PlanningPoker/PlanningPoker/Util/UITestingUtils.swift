//
//  UITestingUtils.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 10.02.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation

class UITestingUtils {
    static let isInUITest: Bool = CommandLine.arguments.contains("--uitesting")
    
    private static let initialAppState: AppState = AppState()
    
    private static let notStartedAppState: AppState = AppState(
        estimationStatus: .notStarted,
        participant: Participant(name: "Karl"),
        otherParticipants: [
            Participant(name: "Pinchy"),
            Participant(name: "Lou")
        ],
        roomName: "CustomerProject",
        estimations: [:]
    )
    
    private static let joinedRoomAppState: AppState = AppState(
        estimationStatus: .inProgress,
        participant: Participant(name: "Karl"),
        otherParticipants: [
            Participant(name: "Pinchy", hasEstimated: true),
            Participant(name: "Lou")
        ],
        roomName: "CustomerProject",
        currentTaskName: "Feature ABC-1",
        estimations: ["Karl": "8"]
    )
    
    private static let endedAppState: AppState = AppState(
        estimationStatus: .ended,
        participant: Participant(name: "Karl"),
        otherParticipants: [
            Participant(name: "Pinchy"),
            Participant(name: "Lou")
        ],
        roomName: "CustomerProject",
        currentTaskName: "Feature ABC-1",
        estimations: [
            "Pinchy": "13",
            "Lou": "13",
            "Karl": "8"
        ]
    )

    static func stateFixtureBasedOnArguments() -> AppState {
        if CommandLine.arguments.contains("--state=notStarted") {
            return notStartedAppState
        } else if CommandLine.arguments.contains("--state=joinedRoom") {
            return joinedRoomAppState
        } else if CommandLine.arguments.contains("--state=ended") {
            return endedAppState
        }
        
        return initialAppState
    }
}
