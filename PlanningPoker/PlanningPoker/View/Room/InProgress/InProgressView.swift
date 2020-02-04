//
//  InProgressView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 20.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct InProgressView: View {
    var currentTaskName: String
    var participantEstimate: String?
    var areEstimationsCompleted: Bool
    let onEstimate: (String) -> Void
    let onShowResult: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            PokerCardDeckView(
                onEstimate: { estimate in self.onEstimate(estimate) },
                currentTaskName: currentTaskName
            )
            .offset(x: 0, y: -20)

            Button(action: self.onShowResult) {
                Text(areEstimationsCompleted ? "Show result" : "Voting in progress...")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(20)
                    .frame(minWidth: 150)
                    .background(Color("primary1"))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .opacity(areEstimationsCompleted ? 1 : 0.4)
                    .disabled(!areEstimationsCompleted)
            }
        }
    }
}

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressView(
            currentTaskName: "Implement the feature",
            participantEstimate: "5",
            areEstimationsCompleted: false,
            onEstimate: { _ in },
            onShowResult: {}
        )
    }
}
