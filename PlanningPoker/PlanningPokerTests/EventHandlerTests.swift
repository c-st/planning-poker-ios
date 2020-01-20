//
//  EventHandlerTests.swift
//  PlanningPokerTests
//
//  Created by Christian Stangier on 17.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Nimble
import XCTest

@testable import PlanningPoker

class EventHandlerTests: XCTestCase {
    func testSingleUserJoining() {
        let userJoinedEvent = UserJoined(
            userName: "Foo",
            isSpectator: false
        )

        let newState =
            EventHandler.handle(
                userJoinedEvent,
                state: AppState()
            )

        expect(newState.otherParticipants).to(haveCount(1))
    }

    func testMultipleUsersJoining() {
        let userJoinedEvent = UserJoined(
            userName: "Foo",
            isSpectator: false
        )

        let otherUserJoinedEvent = UserJoined(
            userName: "Bar",
            isSpectator: false
        )

        let intermediaryState =
            EventHandler.handle(
                userJoinedEvent,
                state: AppState()
            )

        let finalState = EventHandler.handle(
            otherUserJoinedEvent,
            state: intermediaryState
        )

        expect(finalState.otherParticipants).to(haveCount(2))
    }
    
    func testSameUserJoiningMultipleTimes() {
        let initialState = AppState(
            otherParticipants: [
                Participant(id: .init(), name: "Bar")
            ]
        )
        
        let userJoinedEvent = UserJoined(
            userName: "Foo",
            isSpectator: false
        )
        
        let intermediateState = EventHandler.handle(
            userJoinedEvent,
            state: initialState
        )
        
        let finalState = EventHandler.handle(
            userJoinedEvent,
            state: intermediateState
        )
        
        expect(finalState.otherParticipants).to(haveCount(2))
        
    }

    func testUserLeaving() {
        let initialState = AppState(
            otherParticipants: [
                Participant(id: .init(), name: "Foo"),
                Participant(id: .init(), name: "Bar")
            ]
        )

        let userLeftEvent = UserLeft(userName: "Bar")

        let finalState = EventHandler.handle(
            userLeftEvent,
            state: initialState
        )

        expect(finalState.otherParticipants).to(haveCount(1))
    }

    func testUpdateEstimateState() {
        let initialState = AppState(
            otherParticipants: [
                Participant(id: .init(), name: "Foo"),
                Participant(id: .init(), name: "Bar")
            ]
        )

        // current backend does not send the timezone at the moment!
        let formatter = ISO8601DateFormatter()
        print(formatter.string(from: Date()))
        let date = DateFormatter.iso8601WithoutTimezone.date(from: "2020-01-17T14:13:07")

        let requestStartEstimateEvent = RequestStartEstimation(
            userName: "Foo",
            taskName: "implementing planning poker",
            startDate: date ?? Date()
        )

        let finalState = EventHandler.handle(
            requestStartEstimateEvent,
            state: initialState
        )

        expect(finalState.estimationStatus).to(equal(.inProgress))
        expect(finalState.estimationStart).to(equal(date))
        expect(finalState.currentTaskName).to(equal("implementing planning poker"))
    }
}
