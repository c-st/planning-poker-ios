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
                radius: 100,
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
    
    var medianRadians: Double {
        let medianAngle = (startAngle + endAngle) / 2
        return medianAngle * .pi / 180
    }
    
    var labelXPosition: CGFloat {
        return 100 + (60 * CGFloat(cos(medianRadians)))
    }
    
    var labelYPosition: CGFloat {
        return 100 + (60 * CGFloat(sin(medianRadians)))
    }
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
                ZStack {
                    PieSegment(
                        startAngle: self.segmentData[index].startAngle,
                        endAngle: self.segmentData[index].endAngle
                    )
                    .fill(self.colors[index % self.colors.count])
                    Text("\(index)")
                        .position(
                            x: self.segmentData[index].labelXPosition,
                            y: self.segmentData[index].labelYPosition
                        )
                }
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
