//
//  Planning_PokerUITests.swift
//  Planning PokerUITests
//
//  Created by Christian Stangier on 31.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import XCTest

class Planning_PokerUITests: XCTestCase {
    private var app: XCUIApplication?

    override func setUp() {
        app = XCUIApplication()
        app!.launchArguments.append("--uitesting") // see SceneDelegate
        continueAfterFailure = false
        app!.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJoinARoom() {
        app!.textFields["roomTextField"].clearAndEnterText(text: "Test")
        app!.textFields["nameTextField"].clearAndEnterText(text: "Franz")
        app!.buttons["joinRoomLink"].tap()

        // Leave room:
        // app.navigationBars["Test"].buttons["Planning Poker"].tap()
    }
}
