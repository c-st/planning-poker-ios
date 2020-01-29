//
//  EndedView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 20.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SDWebImageSwiftUI
import SwiftUI

struct EndedView: View {
    var participants: [Participant]
    var participantsByEstimate: [String: [String]]
    var isCatConsensus: Bool?
    let onStartEstimation: (String) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Result")
                .font(.title)
                .fontWeight(.bold)

            PieChartView(segmentData: calculatePieChartAngles())
                .frame(width: 200, height: 200)
                .shadow(radius: 10)

            Divider()

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

                ForEach(self.participantsByEstimate.keys.sorted(), id: \.self) { estimate in
                    HStack {
                        Text(estimate)
                            .font(.headline)
                        Spacer()

                        Text(self.participantsByEstimate[estimate]!.joined(separator: ", "))
                            .font(.headline)
                    }
                }
            }

            Divider()

//            if isCatConsensus != nil && isCatConsensus! {
//                AnimatedImage(url: URL(string: "https://thecatapi.com/api/images/get?format=src&type=gif"))
//                .resizable()
//                .scaledToFit()
//                .frame(width: 200, height: 200, alignment: .center)
//            }
//
//            Divider()

            StartEstimationFormView(
                onStartEstimation: onStartEstimation
            )
        }
        .padding()
        .cornerRadius(10)
        .padding()
    }

    private func calculatePieChartAngles() -> [SegmentData] {
        let totalParticipantCount = Double(participantsByEstimate.values.flatMap({ $0 }).count)
        var lastAngle = 0.0

        return participantsByEstimate.map { _, estimators in
            let estimateCount = Double(estimators.count)
            let startAngle = lastAngle
            lastAngle = startAngle + estimateCount / totalParticipantCount * 360
            return SegmentData(startAngle: startAngle, endAngle: lastAngle)
        }
    }
}

struct EndedView_Previews: PreviewProvider {
    static var previews: some View {
        EndedView(
            participants: [
                Participant(name: "Our User", hasEstimated: true),
                Participant(name: "Foo", hasEstimated: true),
                Participant(name: "Bar", hasEstimated: true),
                Participant(name: "Another", hasEstimated: true)
            ],
            participantsByEstimate: [
                "3": ["Our User", "Foo"],
                "5": ["Bar"],
                "8": ["Another"]
            ],

            isCatConsensus: true,
            onStartEstimation: { _ in }
        )
        // .colorScheme(.dark)
    }
}
