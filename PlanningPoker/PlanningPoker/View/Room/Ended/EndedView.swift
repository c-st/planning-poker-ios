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
    var participantsByEstimate: [String? : [Participant]]
    var isCatConsensus: Bool?
    let onStartEstimation: (String) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Result")
                .font(.title)
                .fontWeight(.bold)
            
            PieChartView(segmentData: calculatePieChartAngles())
                .frame(width: 200, height: 200)
            
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
        let totalParticipantCount = Double(participants.count)
        var lastAngle = 0.0
        
        return participantsByEstimate.map { (key, estimators) in
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
                Participant(name: "Foo", hasEstimated: true, currentEstimate: "3"),
                Participant(name: "Bar", hasEstimated: true, currentEstimate: "5")
            ],
            participantsByEstimate: [
                "3": [Participant(name: "Foo", hasEstimated: true, currentEstimate: "3")],
                "5": [Participant(name: "Bar", hasEstimated: true, currentEstimate: "5")]
            ],
            isCatConsensus: true,
            onStartEstimation: { _ in }
        )
        // .colorScheme(.dark)
    }
}
