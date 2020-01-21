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
    let onStartEstimation: (String) -> Void

    var body: some View {
        VStack {
            Text("Estimation result")
                .font(.headline)

            StartEstimationFormView(
                onStartEstimation: onStartEstimation
            )

            HStack {
                Text("Name").font(.headline)
                Spacer()
                Text("Estimate").font(.headline)
            }

            ForEach(self.participants) { participant in
                HStack {
                    Text(participant.name)
                    Spacer()
                    Text(participant.currentEstimate!)
                }
            }
        }
    }
}

struct EndedView_Previews: PreviewProvider {
    static var previews: some View {
        EndedView(
            participants: [
                Participant(name: "Foo", hasEstimated: true, currentEstimate: "3"),
                Participant(name: "Bar", hasEstimated: true, currentEstimate: "5")
            ],
            onStartEstimation: { _ in }
        )
    }
}
