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
        "0",
        "1",
        "2",
        "3",
        "5",
        "8",
        "13",
        "20",
        "40",
        "100",
        "???"
    ]

    let participantEstimate: String?

    let onEstimate: (String) -> Void

    let onShowResult: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Button(action: self.onShowResult) {
                Text("Show result")
            }
            ForEach(self.possibleEstimates, id: \.self) { estimate in
                Button(action: { self.onEstimate(estimate) }) {
                    Text(estimate)
                        .font(.caption)
                        .fontWeight(.bold)
                        .frame(width: 30)
                        .padding()
                        .background(self.participantEstimate == estimate ? Color.green : Color.blue)
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressView(participantEstimate: "5", onEstimate: {_ in }, onShowResult: {})
    }
}
