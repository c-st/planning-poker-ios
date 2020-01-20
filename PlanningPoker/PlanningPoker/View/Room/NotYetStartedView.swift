//
//  NotYetStartedView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 20.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct NotYetStartedView: View {
    @Binding var newTaskName: String

    let onStartEstimation: () -> Void

    var body: some View {
        VStack {
            Text("Waiting for estimation start...")

            TextField("Task name", text: self.$newTaskName)
            Button(action: { self.onStartEstimation() }) {
                Text("Start")
            }
        }
    }
}

struct NotYetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        NotYetStartedView(
            newTaskName: .constant("Implement view"),
            onStartEstimation: { print("Start estimating!") }
        )
    }
}
