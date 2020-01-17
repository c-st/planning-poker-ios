//
//  EventParserTests.swift
//  PlanningPokerTests
//
//  Created by Edward Byne on 17/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import XCTest
import Nimble
@testable import PlanningPoker

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
        
        print("parsedEvent: \(parsedEvent)")
        
        expect(parsedEvent).to(beAnInstanceOf(UserJoined.self))
        expect((parsedEvent as! UserJoined).userName).to(equal("Jane Doe"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
