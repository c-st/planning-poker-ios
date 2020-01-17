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

    func testUserLeaving() {
        let initialState = AppState(otherParticipants: [
            Participant(id: .init(), name: "Foo"),
            Participant(id: .init(), name: "Bar")
        ])

        let userLeftEvent = UserLeft(userName: "Bar")

        let finalState = EventHandler.handle(
            userLeftEvent,
            state: initialState
        )

        expect(finalState.otherParticipants).to(haveCount(1))
    }
    
    func testUpdateEstimateState() {
        let initialState = AppState(otherParticipants: [
            Participant(id: .init(), name: "Foo"),
            Participant(id: .init(), name: "Bar")
        ])
        
        let requestStartEstimateEvent = RequestStartEstimation(
            userName: "Foo",
            taskName: "implementing planning poker",
            startDate: "2020-01-17T14:13:07.501Z"
        )
        
        let finalState = EventHandler.handle(
            requestStartEstimateEvent,
            state: initialState
        )
        
        expect(finalState.estimationStatus).to(equal(.inProgress))
    }
}
