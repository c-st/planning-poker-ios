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
        VStack {
            Text("Result")
                .font(.title)
                .fontWeight(.bold)

            PieChartView(segmentData: calculateSegmentData())
                .frame(width: 200, height: 200)

            VStack(spacing: 10) {
                HStack {
                    Text("Estimate")
                        .fontWeight(.bold)

                    Spacer()
                    Text("Participants")
                        .fontWeight(.bold)
                }

                ForEach(self.participantsByEstimate.keys.sorted(), id: \.self) { estimate in
                    HStack {
                        Text(estimate)
                        Spacer()

                        Text(self.participantsByEstimate[estimate]!.joined(separator: ", "))
                    }
                }
            }
            .font(.subheadline)

            if isCatConsensus != nil && isCatConsensus! {
                AnimatedImage(url: URL(string: "https://thecatapi.com/api/images/get?format=src&type=gif"))
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 150)
                    .padding(0)
            }

            Divider()

            StartEstimationFormView(
                onStartEstimation: onStartEstimation
            )

            Spacer()
        }
    }

    private func calculateSegmentData() -> [SegmentData] {
        let totalParticipantCount = participantsByEstimate.values.flatMap { $0 }.count
        var lastAngle = 0.0

        let segments: [SegmentData] = participantsByEstimate.map { estimate, estimators in
            let estimateCount = estimators.count
            let startAngle = lastAngle
            let endAngle = lastAngle + (Double(estimateCount) / Double(totalParticipantCount) * 360)
            lastAngle = endAngle
            return SegmentData(startAngle: startAngle, endAngle: endAngle, estimators: estimators, estimate: estimate)
        }

        return segments
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
