//
//  PieChartView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 27/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct PieSegment: Shape {
    let startAngle: Double
    let endAngle: Double

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addArc(
                center: CGPoint(x: 100, y: 100),
                radius: 50,
                startAngle: .degrees(startAngle),
                endAngle: .degrees(endAngle),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: 100, y: 100))
            path.closeSubpath()
        }
    }
}

struct SegmentData: Identifiable {
    let id: UUID = UUID()
    let startAngle: Double
    let endAngle: Double
}

struct PieChartView: View {
    let colors: [Color] = [
        Color.green,
        Color.blue,
        Color.yellow,
        Color.purple,
        Color.orange,
        Color.pink,
        Color.gray,
        Color.red,
    ]

    var segmentData: [SegmentData]

    var body: some View {
        ZStack {
            ForEach(0..<segmentData.count, id: \.self) { index in
                PieSegment(
                    startAngle: self.segmentData[index].startAngle,
                    endAngle: self.segmentData[index].endAngle
                )
                .fill(self.colors[index % self.colors.count])
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(
            segmentData: [
                SegmentData(startAngle: 0, endAngle: 120),
                SegmentData(startAngle: 120, endAngle: 220),
                SegmentData(startAngle: 220, endAngle: 230),
                SegmentData(startAngle: 230, endAngle: 240),
                SegmentData(startAngle: 240, endAngle: 250),
                SegmentData(startAngle: 250, endAngle: 360),
            ]
        )
    }
}
