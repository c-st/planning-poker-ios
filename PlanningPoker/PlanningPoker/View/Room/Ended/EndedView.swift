//
//  EndedView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 20.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct EndedView: View {
    var participants: [Participant]
    var isCatConsensus: Bool?
    let onStartEstimation: (String) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Result")
                .font(.title)
                .fontWeight(.bold)
            
            PieChartView(segmentData: [SegmentData(startAngle: 0, endAngle: 360)])
                .frame(width: 200, height: 200)

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
                
                if isCatConsensus != nil && isCatConsensus! {
                    AnimatedImage(url: URL(string: "https://thecatapi.com/api/images/get?format=src&type=gif"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300, alignment: .center)
                }
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
            isCatConsensus: true,
            onStartEstimation: { _ in }
        )
        // .colorScheme(.dark)
    }
}
