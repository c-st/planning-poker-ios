//
//  View+EmbedInNavigationView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 10.02.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

extension View {
    func embedInNavigation() -> some View {
        NavigationView { self }
    }
}
