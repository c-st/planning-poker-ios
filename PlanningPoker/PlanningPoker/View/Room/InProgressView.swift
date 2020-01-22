//
//  InProgressView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 20.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct InProgressView: View {
    let possibleEstimates = [
        ["0", "1", "2"],
        ["3", "5", "8"],
        ["13", "20", "40"],
        ["100", "???"],
    ]

    var currentTaskName: String?
    var participantEstimate: String?
    let onEstimate: (String) -> Void
    let onShowResult: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(currentTaskName!)
                .font(.title)
                .fontWeight(.black)

            Button(action: self.onShowResult) {
                Text("Show result")
            }

            VStack(spacing: 0) {
                ForEach(self.possibleEstimates, id: \.self) { estimateRow in
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        ForEach(estimateRow, id: \.self) { estimate in
                            Button(action: { self.onEstimate(estimate) }) {
                                Text(estimate)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .frame(width: 30, height: 30)
                                    .animation(.spring())
                                    .padding()
                                    .background(
                                        self.participantEstimate == estimate ? Color.green : Color.blue
                                    )
                                    .foregroundColor(Color.white)
                                    .padding()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressView(
            participantEstimate: "5",
            onEstimate: { _ in },
            onShowResult: {}
        )
    }
}
