//
//  Store.swift
//  PlanningPoker
//
//  Created by Edward Byne on 16/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation
import Combine

struct Participant: Identifiable {
    var id: UUID
    var name: String
}

final class Store: ObservableObject {
    @Published var participants: [Participant] = [
        .init(id: .init(), name: "Ed"),
        .init(id: .init(), name: "Christian"),
        .init(id: .init(), name: "Johannes"),
        .init(id: .init(), name: "Peppa Pig")
    ]
}
