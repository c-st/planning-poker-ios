//
//  EventHandler.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 17.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation

public struct AppState {
    var otherParticipants: [Participant]
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
            return AppState(otherParticipants: newParticipants)

        case let event as UserLeft:
            let newParticipants =
                state.otherParticipants.filter {
                    $0.name != event.userName
                }
            return AppState(otherParticipants: newParticipants)

        default:
            print("Ignoring event", anyEvent)
            return state
        }
    }

    public static let initialState: AppState = AppState(otherParticipants: [])
}
