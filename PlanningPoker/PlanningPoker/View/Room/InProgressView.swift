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

//            VStack(alignment: .leading, spacing: 0) {
//                ForEach(self.possibleEstimates, id: \.self) { estimateRow in
//                    HStack(spacing: 0) {
//                        ForEach(estimateRow, id: \.self) { estimate in
//                            Button(action: { self.onEstimate(estimate) }) {
//                                Text(estimate)
//                                    .font(.caption)
//                                    .fontWeight(.bold)
//                                    .frame(width: 30, height: 40)
//                                    .animation(.spring())
//                                    .padding()
//                                    .background(
//                                        self.participantEstimate == estimate ? Color.green : Color.white.opacity(0.4)
//                                    )
//                                    .foregroundColor(Color.white)
//                                    .cornerRadius(10)
//                                    .padding(5)
//                            }
//                        }
//                    }
//                }
//            }

            Button(action: self.onShowResult) {
                Text("Show result")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(20)
                    .foregroundColor(Color.blue)
                    .background(Color.white)
                    .cornerRadius(10)
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
