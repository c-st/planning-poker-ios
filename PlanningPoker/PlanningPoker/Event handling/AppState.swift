//
//  AppState.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 10.02.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation

public struct AppState {
    var estimationStatus: EstimationStatus = .notStarted
    var participant: Participant?
    var otherParticipants: [Participant] = []
    var roomName: String?
    var isShowCats: Bool = true
    var currentTaskName: String?
    var estimationStart: Date?

    var estimations: [String: String] = [:]

    var participantsByEstimate: [String: [String]]? {
        return Dictionary(
            grouping: self.estimations.keys,
            by: { key -> String in
                let value = estimations[key]!
                return value
            }
        )
    }

    var ourEstimate: String? {
        guard self.participant != nil else { return nil }
        return self.estimations[self.participant!.name]
    }

    var areEstimationsCompleted: Bool {
        guard let ourParticipant = self.participant else { return false }
        let allParticipants = self.otherParticipants + [ourParticipant]
        return allParticipants.allSatisfy { $0.hasEstimated }
    }

    var isCatConsensus: Bool? {
        guard self.estimationStatus == .ended, let byEstimate = participantsByEstimate else {
            return nil
        }

        return self.isShowCats && byEstimate.count == 1
    }

    enum EstimationStatus {
        case notStarted
        case inProgress
        case ended
    }
}
