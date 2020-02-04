//
//  PokerCardViewTests.swift
//  PlanningPokerTests
//
//  Created by Edward Byne on 04/02/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Nimble
import XCTest

@testable import Planning_Poker

class PokerCardDeckViewTests: XCTestCase {
    func testInitialAngle() {
        let view = PokerCardDeckView(
            onEstimate: { _ in },
            currentTaskName: "Some task"
        )
        
//        view.calculateAngle
    }
}
