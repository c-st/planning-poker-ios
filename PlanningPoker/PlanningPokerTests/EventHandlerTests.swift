//
//  EventHandlerTests.swift
//  PlanningPokerTests
//
//  Created by Christian Stangier on 17.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Nimble
import XCTest

@testable import Planning_Poker

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
                Participant(name: "Bar")
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

    func testOurUsingJoining() {
        let initialState = AppState(
            participant: Participant(name: "Our user"),
            otherParticipants: [
                Participant(name: "Foo"),
                Participant(name: "Bar")
            ]
        )

        let userJoinedEvent = UserJoined(
            userName: "Our user",
            isSpectator: false
        )

        let finalState = EventHandler.handle(
            userJoinedEvent,
            state: initialState
        )

        expect(finalState.otherParticipants).to(haveCount(2))
    }

    func testUserLeaving() {
        let initialState = AppState(
            otherParticipants: [
                Participant(name: "Foo"),
                Participant(name: "Bar")
            ]
        )

        let userLeftEvent = UserLeft(userName: "Bar")

        let finalState = EventHandler.handle(
            userLeftEvent,
            state: initialState
        )

        expect(finalState.otherParticipants).to(haveCount(1))
    }

    func testStartNewEstimation() {
        let initialState = AppState(
            otherParticipants: [
                Participant(name: "Foo"),
                Participant(name: "Bar")
            ]
        )

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

    func testOurUserHasEstimated() {
        let initialState = AppState(
            estimationStatus: .inProgress,
            participant: Participant(name: "Our user"),
            otherParticipants: [
                Participant(name: "Foo"),
                Participant(name: "Bar")
            ],
            roomName: "Test room",
            currentTaskName: "Test task",
            estimationStart: Date()
        )

        let userHasEstimatedEvent = UserHasEstimated(
            userName: "Our user",
            taskName: "Test task"
        )

        let finalState = EventHandler.handle(
            userHasEstimatedEvent, state: initialState
        )

        expect(finalState.participant!.hasEstimated).to(beTrue())
    }

    func testOtherUserHasEstimated() {
        let initialState = AppState(
            estimationStatus: .inProgress,
            participant: Participant(name: "Our user"),
            otherParticipants: [
                Participant(name: "Foo"),
                Participant(name: "Bar")
            ],
            roomName: "Test room",
            currentTaskName: "Test task",
            estimationStart: Date()
        )

        let userHasEstimatedEvent = UserHasEstimated(
            userName: "Foo",
            taskName: "Test task"
        )

        let finalState = EventHandler.handle(
            userHasEstimatedEvent, state: initialState
        )

        expect(finalState.otherParticipants.first!.hasEstimated).to(beTrue())
    }

    func testFinishEstimation() {
        let taskName = "Test task"
        let start = Date()

        let initialState = AppState(
            estimationStatus: .inProgress,
            participant: Participant(name: "Our user"),
            otherParticipants: [
                Participant(name: "Foo"),
                Participant(name: "Bar")
            ],
            roomName: "Test room",
            currentTaskName: taskName,
            estimationStart: start
        )

        let estimationResultEvent = EstimationResult(
            taskName: "Test task",
            startDate: start,
            endDate: Date(),
            estimates: [
                UserEstimation(userName: "Our user", estimate: "1"),
                UserEstimation(userName: "Foo", estimate: "3"),
                UserEstimation(userName: "Bar", estimate: "5")
            ]
        )

        let finalState = EventHandler.handle(estimationResultEvent, state: initialState)

        expect(finalState.estimationStatus).to(equal(.ended))
        expect(finalState.estimations[finalState.otherParticipants.first!.name]).to(equal("3"))
        expect(finalState.estimations[finalState.otherParticipants.last!.name]).to(equal("5"))
    }

    func testStartNextNewEstimation() {
        let initialState = AppState(
            estimationStatus: .ended,
            participant: Participant(
                name: "Our user",
                hasEstimated: true
            ),
            otherParticipants: [
                Participant(
                    name: "Foo",
                    hasEstimated: true
                ),
                Participant(
                    name: "Bar",
                    hasEstimated: true
                )
            ],
            estimations: ["Our user": "1", "Foo": "5", "Bar": "3"]
        )

        let requestStartEstimateEvent = RequestStartEstimation(
            userName: "Foo",
            taskName: "Another task",
            startDate: Date()
        )

        let finalState = EventHandler.handle(
            requestStartEstimateEvent,
            state: initialState
        )

        expect(finalState.estimationStatus).to(equal(.inProgress))
        expect(finalState.participant?.hasEstimated).to(beFalse())
        expect(finalState.ourEstimate).to(beNil())

        expect(finalState.otherParticipants.first!.hasEstimated).to(beFalse())
        expect(finalState.estimations[finalState.otherParticipants.first!.name]).to(beNil())

        expect(finalState.otherParticipants.last!.hasEstimated).to(beFalse())
        expect(finalState.estimations[finalState.otherParticipants.last!.name]).to(beNil())
    }

    func testUserLeavesAfterEstimationHasEnded() {
        let initialState = AppState(
            estimationStatus: .ended,
            participant: Participant(
                name: "Our user",
                hasEstimated: true
            ),
            otherParticipants: [
                Participant(
                    name: "Foo",
                    hasEstimated: true
                ),
                Participant(
                    name: "Bar",
                    hasEstimated: true
                )
            ]
        )

        let userLeftEvent = UserLeft(userName: "Foo")
        let finalState = EventHandler.handle(
            userLeftEvent,
            state: initialState
        )

        expect(finalState.estimationStatus).to(equal(.ended))
        expect(finalState.otherParticipants.first!.name).to(equal("Foo"))
        expect(finalState.otherParticipants.first!.hasEstimated).to(beTrue())
        expect(finalState.estimations[finalState.otherParticipants.first!.name]).to(equal("5"))

        expect(finalState.otherParticipants.last!.hasEstimated).to(beTrue())
        expect(finalState.otherParticipants.last!.name).to(equal("Bar"))
        expect(finalState.estimations[finalState.otherParticipants.last!.name]).to(equal("3"))
    }
}
