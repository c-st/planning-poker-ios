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

    let onEstimate: (String) -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            ForEach(self.possibleEstimates, id: \.self) { estimate in
                Button(action: { self.onEstimate(estimate) }) {
                    Text(estimate)
                        .font(.caption)
                        .fontWeight(.bold)
                        .frame(width: 30)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressView(onEstimate: { print("You estimated \($0)") })
    }
}
