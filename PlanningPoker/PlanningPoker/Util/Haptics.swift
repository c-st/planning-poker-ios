//
//  Haptics.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 22.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import UIKit

struct Haptics {
    private static let notificationGenerator = UINotificationFeedbackGenerator()
    private static let lightFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    private static let mediumFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    private static let heavyFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    static func success() {
        Self.notificationGenerator.notificationOccurred(.success)
    }
    
    static func warning() {
        Self.notificationGenerator.notificationOccurred(.warning)
    }
    
    static func light() {
        Self.lightFeedbackGenerator.impactOccurred()
    }
    
    static func medium() {
        Self.mediumFeedbackGenerator.impactOccurred()
    }
    
    static func heavy() {
        Self.heavyFeedbackGenerator.impactOccurred()
    }
}
