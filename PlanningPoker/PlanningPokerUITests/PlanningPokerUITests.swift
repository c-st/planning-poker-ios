//
//  Planning_PokerUITests.swift
//  Planning PokerUITests
//
//  Created by Christian Stangier on 31.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import XCTest

class PlanningPokerUITests: XCTestCase {
    private var app: XCUIApplication?

    override func setUp() {}
    override func tearDown() {}

    func testJoinARoom() {
        _ = launchApp()
        snapshot("01JoinRoomScreen")

//        let roomTextField = app.textFields["roomTextField"]
//        roomTextField.clearAndEnterText(text: "Test")
//
//        let nameTextField = app.textFields["nameTextField"]
//        nameTextField.clearAndEnterText(text: "Franz")
//
//        app.buttons["joinRoomLink"].tap()
//        snapshot("02NotStartedScreen")
    }

    func testNotStartedYet() {
        _ = launchApp(withState: "notStarted")
        snapshot("02NotStartedScreen")
    }

    func testShowEstimating() {
        _ = launchApp(withState: "joinedRoom")
        snapshot("03OngoingEstimation")
    }
    
    func testEstimationEnded() {
        _ = launchApp(withState: "ended")
        snapshot("04EndedEstimation")
    }

    private func launchApp(withState: String = "initial") -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launchArguments.append("--state=\(withState)")
        continueAfterFailure = false
        setupSnapshot(app)
        app.launch()
        return app
    }
}
