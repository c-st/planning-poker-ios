//
//  PieChartLabelView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 30/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct PieChartSegmentLabelView: View {
    let segmentData: SegmentData

    var body: some View {
        VStack(spacing: 2) {
            HStack {
                Image("Stopwatch")
                Spacer()
                Text(segmentData.estimate)
            }
            HStack {
                Image("Person")
                Spacer()
                Text("\(segmentData.estimators)")
            }
        }

        .frame(width: 40, height: 30)
        .padding(3)
        .font(.caption)
        .background(Color.white)
        .foregroundColor(Color.black)
        .cornerRadius(5)
        .position(
            x: segmentData.labelXPosition,
            y: segmentData.labelYPosition
        )
    }
}

struct PieChartSegmentLabelView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartSegmentLabelView(
            segmentData: SegmentData(startAngle: 0, endAngle: 50, estimators: 3, estimate: "3")
        )
    }
}
