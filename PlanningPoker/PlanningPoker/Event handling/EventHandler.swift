//
//  EventHandler.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 17.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation

public class EventHandler {
    public static func handle(_ anyEvent: Any, state: AppState) -> AppState {
        switch anyEvent {
        case let event as UserJoined:
            let isCurrentParticipant = state.participant?.name == event.userName
            let isAnotherParticipant = state.otherParticipants.contains {
                $0.name == event.userName
            }

            if isCurrentParticipant || isAnotherParticipant {
                return state
            }

            let newParticipants = state.otherParticipants +
                [Participant(name: event.userName)]

            return AppState(
                estimationStatus: state.estimationStatus,
                participant: state.participant,
                otherParticipants: newParticipants,
                roomName: state.roomName,
                currentTaskName: state.currentTaskName,
                estimationStart: state.estimationStart,
                estimations: state.estimations
            )

        case let event as UserLeft:
            let newParticipants =
                state.otherParticipants.filter {
                    $0.name != event.userName
                }
            return AppState(
                estimationStatus: state.estimationStatus,
                participant: state.participant,
                otherParticipants: newParticipants,
                roomName: state.roomName,
                currentTaskName: state.currentTaskName,
                estimationStart: state.estimationStart,
                estimations: state.estimations
            )

        case let event as RequestStartEstimation:
            func resetEstimationStatus(participant: Participant) -> Participant {
                Participant(
                    id: participant.id,
                    name: participant.name,
                    hasEstimated: false
                )
            }

            return AppState(
                estimationStatus: .inProgress,
                participant: state.participant.map(resetEstimationStatus),
                otherParticipants: state.otherParticipants.map(resetEstimationStatus),
                roomName: state.roomName,
                currentTaskName: event.taskName,
                estimationStart: event.startDate,
                estimations: [:]
            )

        case let event as UserHasEstimated:
            func markAsEstimatedIfNecessary(participant: Participant) -> Participant {
                if participant.name == event.userName {
                    return Participant(
                        id: participant.id,
                        name: participant.name,
                        hasEstimated: true
                    )
                }
                return participant
            }

            return AppState(
                estimationStatus: state.estimationStatus,
                participant: state.participant.map(markAsEstimatedIfNecessary),
                otherParticipants: state.otherParticipants.map(markAsEstimatedIfNecessary),
                roomName: state.roomName,
                currentTaskName: state.currentTaskName,
                estimationStart: state.estimationStart,
                estimations: state.estimations
            )

        case let event as EstimationResult:
            func updateEstimateIfNecessary(participant: Participant) -> Participant {
                let participantEstimate = event.estimates.first { estimate in
                    estimate.userName == participant.name
                }
                guard participantEstimate != nil else {
                    return participant
                }

                return Participant(
                    id: participant.id,
                    name: participant.name,
                    hasEstimated: true
                )
            }

            let estimations = event.estimates.reduce([String: String]()) { (accumulator, estimation) -> [String: String] in
                var accumulator = accumulator
                accumulator[estimation.userName] = estimation.estimate
                return accumulator
            }

            return AppState(
                estimationStatus: .ended,
                participant: state.participant.map(updateEstimateIfNecessary),
                otherParticipants: state.otherParticipants.map(updateEstimateIfNecessary),
                roomName: state.roomName,
                currentTaskName: state.currentTaskName,
                estimationStart: state.estimationStart,
                estimations: estimations
            )

        case is HeartBeat:
            return state

        default:
            print("Ignoring event", anyEvent)
            return state
        }
    }
}
