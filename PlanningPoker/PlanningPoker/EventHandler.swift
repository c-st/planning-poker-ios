//
//  EventHandler.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 17.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation

public struct AppState {
    var estimationStatus: EstimationStatus = .notStarted
    var participantName: String?
    var otherParticipants: [Participant] = []
    var roomName: String?
    var currentTaskName: String?
    var estimationStart: Date?

    enum EstimationStatus {
        case notStarted
        case inProgress
        case ended
    }
}

struct Participant: Identifiable {
    var id: UUID
    var name: String
}

public class EventHandler {
    public static func handle(_ anyEvent: Any, state: AppState) -> AppState {
        switch anyEvent {
        case let event as UserJoined:
            let newParticipants =
                state.otherParticipants + [Participant(id: .init(), name: event.userName)]
            return AppState(
                estimationStatus: state.estimationStatus,
                participantName: state.participantName,
                otherParticipants: newParticipants,
                roomName: state.roomName,
                currentTaskName: state.currentTaskName,
                estimationStart: state.estimationStart
            )

        case let event as UserLeft:
            let newParticipants =
                state.otherParticipants.filter {
                    $0.name != event.userName
                }
            return AppState(
                estimationStatus: state.estimationStatus,
                participantName: state.participantName,
                otherParticipants: newParticipants,
                roomName: state.roomName,
                currentTaskName: state.currentTaskName,
                estimationStart: state.estimationStart
            )

        case let event as RequestStartEstimation:
            return AppState(
                estimationStatus: .inProgress,
                participantName: state.participantName,
                otherParticipants: state.otherParticipants,
                roomName: state.roomName,
                currentTaskName: event.taskName,
                estimationStart: event.startDate
            )

        case is HeartBeat:
            return state

        default:
            print("Ignoring event", anyEvent)
            return state
        }
    }
}
