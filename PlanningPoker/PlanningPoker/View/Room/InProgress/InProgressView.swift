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
    let onEstimate: (String) -> Void
    let onShowResult: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            PokerCardDeckView(
                onEstimate: { estimate in self.onEstimate(estimate) },
                currentTaskName: currentTaskName
            )

            Button(action: self.onShowResult) {
                Text("Show result")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(20)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
        }
    }
}

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressView(
            currentTaskName: "Implement the feature",
            participantEstimate: "5",
            onEstimate: { _ in },
            onShowResult: {}
        )
    }
}
