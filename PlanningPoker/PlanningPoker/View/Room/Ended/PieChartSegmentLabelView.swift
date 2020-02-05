//
//  PieChartLabelView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 30/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct PieChartSegmentLabelView: View {
    let data: SegmentData
    let isSelected: Bool
    let isAnotherSelected: Bool

    var isLabelDisplayed: Bool {
        if isSelected {
            return true
        }
        if isAnotherSelected {
            return false
        }
        return data.endAngle - data.startAngle >= 50
    }

    var body: some View {
        VStack(spacing: 2) {
            HStack {
                Image(systemName: "stopwatch.fill")
                    .font(.headline)

                Text(data.estimate)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            if isSelected {
                VStack(spacing: 0) {
                    Divider()
                        .padding(6)
                    ForEach(data.estimators, id: \.self) { estimator in
                        Text(estimator)
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .frame(
            width: !isLabelDisplayed ? 0 : isSelected ? 80 : 60,
            height: !isLabelDisplayed ? 0 : isSelected ? nil : 30
        )
        .padding(!isLabelDisplayed ? 0 : isSelected ? 10 : 5)
        .opacity(!isLabelDisplayed ? 0 : 1.0)
        .background(Color.white)
        .foregroundColor(Color.black)
        .cornerRadius(5)
        .position(
            x: data.labelXPosition,
            y: data.labelYPosition
        )
    }
}

struct PieChartSegmentLabelView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PieChartSegmentLabelView(
                data: SegmentData(startAngle: 0, endAngle: 50, estimators: ["Hans", "Franz", "Johanna"], estimate: "???"),
                isSelected: false,
                isAnotherSelected: false
            )
            PieChartSegmentLabelView(
                data: SegmentData(startAngle: 0, endAngle: 50, estimators: ["Hans", "Franz", "Johanna"], estimate: "3"),
                isSelected: true,
                isAnotherSelected: false
            )
        }
        .previewLayout(.fixed(width: 320, height: 250.0))
        .colorScheme(.light)
    }
}
