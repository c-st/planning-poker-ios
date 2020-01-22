//
//  NewInProgressView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 22/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct NewInProgressView: View {
//    let possibleEstimates = [
//        ["0", "1", "2"],
//        ["3", "5", "8"],
//        ["13", "20", "40"],
//        ["100", "???"],
//    ]
//
//    var currentTaskName: String?
//    var participantEstimate: String?
//    let onEstimate: (String) -> Void
//    let onShowResult: () -> Void

    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    PokerCardView().stacked(at: 0, in: 3)
                    PokerCardView().stacked(at: 1, in: 3)
                    PokerCardView().stacked(at: 2, in: 3)
                }
            }
        }
        
        
//        Text("5")
//            .font(.caption)
//            .fontWeight(.bold)
//            .frame(width: 30, height: 40)
//            .animation(.spring())
//            .padding()
//            .background(Color.green)
//            .foregroundColor(Color.white)
//            .cornerRadius(10)
//            .padding(5)

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

//            Divider()
//            Button(action: self.onShowResult) {
//                Text("Show result")
//                    .font(.caption)
//                    .fontWeight(.bold)
//                    .padding(20)
//                    .foregroundColor(Color.blue)
//                    .background(Color.white)
//                    .cornerRadius(10)
//            }
//        }
    }
}

struct NewInProgressView_Previews: PreviewProvider {
    static var previews: some View {
        NewInProgressView(
//            participantEstimate: "5",
//            onEstimate: { _ in },
//            onShowResult: {}
        )
    }
}
