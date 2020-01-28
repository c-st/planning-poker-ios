//
//  AppStateTests.swift
//  PlanningPokerTests
//
//  Created by Edward Byne on 27/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Nimble
@testable import Planning_Poker
import XCTest

class AppStateTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUnknownCatConsensus() {
        let appState = AppState(
        estimationStatus: .inProgress,
        participant: Participant(name: "Our user"),
        otherParticipants: [
            Participant(name: "Foo"),
            Participant(name: "Bar")
        ],
        roomName: "Test room",
        currentTaskName: "Test task",
        estimationStart: Date())

        expect(appState.isCatConsensus).to(beNil())
    }

    func testCatConsensusWithSingleParticipant(
    ) {
        let appState = AppState(
            estimationStatus: .ended,
            participant: Participant(name: "Our user", hasEstimated: true, currentEstimate: "5"),
            otherParticipants: [],
            roomName: "Test room",
            currentTaskName: "Test task",
            estimationStart: Date()
        )
        
        expect(appState.isCatConsensus).to(beTrue())
    }
    
    func testCatConsensusWithMultipleParticipants(
    ) {
        let appState = AppState(
            estimationStatus: .ended,
            participant: Participant(name: "Our user", hasEstimated: true, currentEstimate: "5"),
            otherParticipants: [Participant(name: "Foo", hasEstimated: true, currentEstimate: "5")],
            roomName: "Test room",
            currentTaskName: "Test task",
            estimationStart: Date()
        )
        
        expect(appState.isCatConsensus).to(beTrue())
    }
    
    func testCatNonConsensus() {
        let appState = AppState(
            estimationStatus: .ended,
            participant: Participant(name: "Our user", hasEstimated: true, currentEstimate: "5"),
            otherParticipants: [Participant(name: "Foo", hasEstimated: true, currentEstimate: "8")],
            roomName: "Test room",
            currentTaskName: "Test task",
            estimationStart: Date()
        )
        
        expect(appState.isCatConsensus).to(beFalse())
    }
}