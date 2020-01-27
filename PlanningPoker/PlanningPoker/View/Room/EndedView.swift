//
//  EndedView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 20.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct EndedView: View {
    var participants: [Participant]
    var isCatConsensus: Bool?
    let onStartEstimation: (String) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Result")
                .font(.title)
                .fontWeight(.bold)

            VStack(spacing: 10) {
                HStack {
                    Text("Name")
                        .font(.headline)
                        .fontWeight(.bold)

                    Spacer()
                    Text("Estimate")
                        .font(.headline)
                        .fontWeight(.bold)
                }

                ForEach(self.participants) { participant in
                    HStack {
                        Text(participant.name)
                            .font(.headline)
                        Spacer()

                        if participant.currentEstimate != nil {
                            Text(participant.currentEstimate!)
                                .font(.headline)
                        }
                    }
                }
                
                Text(isCatConsensus.map { $0 ? "😻😻😻" : "🐶🐶🐶"} ?? "")
            }

            Divider()

            StartEstimationFormView(
                onStartEstimation: onStartEstimation
            )
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .padding()
    }
}

struct EndedView_Previews: PreviewProvider {
    static var previews: some View {
        EndedView(
            participants: [
                Participant(name: "Foo", hasEstimated: true, currentEstimate: "3"),
                Participant(name: "Bar", hasEstimated: true, currentEstimate: "5")
            ],
            isCatConsensus: false,
            onStartEstimation: { _ in }
        )
        // .colorScheme(.dark)
    }
}
