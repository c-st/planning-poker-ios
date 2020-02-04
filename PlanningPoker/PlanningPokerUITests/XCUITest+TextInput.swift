//
//  XCUITest+TextInput.swift
//  Planning PokerUITests
//
//  Created by Christian Stangier on 31.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import XCTest

extension XCUIElement {
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()
        
        let deleteString = stringValue
            .map { _ in XCUIKeyboardKey.delete.rawValue }
            .joined(separator: "")

        self.typeText(deleteString)
        self.typeText(text)
    }
}
