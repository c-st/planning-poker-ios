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
    let isSelected: Bool
    
    var radius: Double
    
    var animatableData: Double {
        get { return radius }
        set { radius = newValue }
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addArc(
                center: CGPoint(x: 100, y: 100),
                radius: CGFloat(self.radius),
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
    let estimators: Int
    let estimate: String

    var medianRadians: Double {
        let medianAngle = Angle(degrees: (startAngle + endAngle) / 2)
        return medianAngle.radians
    }

    var labelXPosition: CGFloat {
        return 100 + (70 * CGFloat(cos(medianRadians)))
    }

    var labelYPosition: CGFloat {
        return 100 + (70 * CGFloat(sin(medianRadians)))
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
    @State var selectedSegmentIndex: Int?

    var body: some View {
        ZStack {
            ForEach(0..<segmentData.count, id: \.self) { index in
                ZStack {
                    PieSegment(
                        startAngle: self.segmentData[index].startAngle,
                        endAngle: self.segmentData[index].endAngle,
                        isSelected: index == self.selectedSegmentIndex,
                        radius: index == self.selectedSegmentIndex ? 120.0 : 100
                    )
                    .fill(self.colors[index % self.colors.count])
                        .animation(.easeInOut(duration: 0.5))

                    if (self.segmentData[index].endAngle - self.segmentData[index].startAngle) >= 50 {
                        PieChartSegmentLabelView(segmentData: self.segmentData[index])
                    }
                }
                .gesture(
                    TapGesture().onEnded { _ in
                        self.selectedSegmentIndex = self.selectedSegmentIndex == index ? nil : index
                    }
                )
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(
            segmentData: [
                SegmentData(startAngle: 0, endAngle: 50, estimators: 3, estimate: "3"),
                SegmentData(startAngle: 50, endAngle: 220, estimators: 2, estimate: "12"),
                SegmentData(startAngle: 220, endAngle: 230, estimators: 4, estimate: "8"),
                SegmentData(startAngle: 230, endAngle: 240, estimators: 1, estimate: "0"),
                SegmentData(startAngle: 240, endAngle: 250, estimators: 1, estimate: "13"),
                SegmentData(startAngle: 250, endAngle: 360, estimators: 1, estimate: "???"),
            ]
        ).previewLayout(.fixed(width: 200.0, height: 200.0))
    }
}
