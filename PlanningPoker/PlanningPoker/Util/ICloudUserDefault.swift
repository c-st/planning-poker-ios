//
//  ICloudUserDefault.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 17.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation

@propertyWrapper
struct iCloudUserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue

        // For importing external changes:
        NSUbiquitousKeyValueStore.default.synchronize()
    }

    var wrappedValue: T {
        get {
            if let value = NSUbiquitousKeyValueStore.default.object(forKey: key) as? T {
                return value
            } else {
                NSUbiquitousKeyValueStore.default.set(defaultValue, forKey: key)
                NSUbiquitousKeyValueStore.default.synchronize()
                return defaultValue
            }
        }
        set {
            NSUbiquitousKeyValueStore.default.set(newValue, forKey: key)
            NSUbiquitousKeyValueStore.default.synchronize()
        }
    }
}
