//
//  View+Stacked.swift
//  PlanningPoker
//
//  Created by Edward Byne on 22/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

extension View {
    func hidden(_ bool: Bool) -> some View {
        modifier(HiddenModifier(isHidden: bool))
    }
}

private struct HiddenModifier: ViewModifier {
    fileprivate let isHidden: Bool

    fileprivate func body(content: Content) -> some View {
        Group {
            if isHidden {
                content.hidden()
            } else {
                content
            }
        }
    }
}
