//
//  EventParserTests.swift
//  PlanningPokerTests
//
//  Created by Edward Byne on 17/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Nimble
@testable import PlanningPoker
import XCTest

class EventParserTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserJoinedEvent() {
        let jsonString = "{\"eventType\":\"userJoined\",\"isSpectator\":false,\"userActor\":{},\"userName\":\"Jane Doe\"}"

        let parsedEvent = EventParser.parse(jsonString)

        expect(parsedEvent).to(beAnInstanceOf(UserJoined.self))
        expect((parsedEvent as! UserJoined).userName).to(equal("Jane Doe"))
    }

    func testEstimationResultEvent() {
        let jsonString = "{\"endDate\":\"2020-01-17T12:52:27\",\"estimates\":[{\"estimate\":\"3\",\"userName\":\"Foo\"},{\"estimate\":\"5\",\"userName\":\"Bar\"}],\"eventType\":\"estimationResult\",\"startDate\":\"2020-01-17T12:50:00\",\"taskName\":\"Some task\"}"

        let expectedStartDate = ISO8601DateFormatter().date(from: "2020-01-17T12:50:00+0000")

        let expectedEndDate = ISO8601DateFormatter().date(from: "2020-01-17T12:52:27+0000")

        let parsedEvent = EventParser.parse(jsonString)
        expect(parsedEvent).to(beAnInstanceOf(EstimationResult.self))

        let estimationResultEvent = parsedEvent as! EstimationResult
        expect(estimationResultEvent.startDate).to(equal(expectedStartDate))
        expect(estimationResultEvent.endDate).to(equal(expectedEndDate))

        let firstEstimation = estimationResultEvent.estimates[0]
        expect(firstEstimation.estimate).to(equal("3"))
        expect(firstEstimation.userName).to(equal("Foo"))

        let secondEstimation = estimationResultEvent.estimates[1]
        expect(secondEstimation.estimate).to(equal("5"))
        expect(secondEstimation.userName).to(equal("Bar"))
    }
}
