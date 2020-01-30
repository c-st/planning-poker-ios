//
//  PieChartSegmentView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 30/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct PieSegment: Shape {
    let startAngle: Double
    let endAngle: Double
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

struct PieChartSegmentView: View {
    let data: SegmentData
    let isSelected: Bool
    let isAnotherSelected: Bool
    let color: Color

    var body: some View {
        Group {
            PieSegment(
                startAngle: data.startAngle,
                endAngle: data.endAngle,
                radius: isSelected ? 120.0 : 100.0
            )
            .fill(color)
            .animation(.easeInOut(duration: 0.5))

            if self.isSegmentLabelDisplayed() {
                PieChartSegmentLabelView(segmentData: data)
                    .zIndex(1)
            }
        }
    }

    private func isSegmentLabelDisplayed() -> Bool {
        if isSelected {
            return true
        }
        if isAnotherSelected {
            return false
        }
        return data.endAngle - data.startAngle >= 50
    }
}

struct PieChartSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartSegmentView(
            data: SegmentData(startAngle: 0, endAngle: 50, estimators: 3, estimate: "3"),
            isSelected: false,
            isAnotherSelected: false,
            color: Color.red
        )
    }
}
