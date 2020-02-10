//
//  NewInProgressView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 22/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct PokerCardDeckView: View {
    let threshold: CGFloat = 200
    let degree = 12.0

    let possibleEstimates: [String] = [
        "0", "1", "2", "3",
        "5", "8", "13", "20",
        "40", "100", "???"
    ].reversed()

    @State private var offset = CGSize.zero
    @State private var draggedCardIndex: Int? = nil
    @State private var selectedCardIndex: Int? = nil

    let onEstimate: (String) -> Void
    var currentTaskName: String

    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    Text(self.currentTaskName)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 60, leading: 50, bottom: 60, trailing: 50))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                }
                .frame(minWidth: geometry.size.width - 30)
                .overlay(
                    Rectangle()
                        .strokeBorder(
                            style: StrokeStyle(
                                lineWidth: 2,
                                dash: [5]
                            )
                        )
                        .foregroundColor(.gray)
                        .opacity(0.4)
                )
            }

            Spacer()

            ZStack {
                ForEach(0..<possibleEstimates.count, id: \.self) { index in
                    self.buildPokerCardViewAt(index)
                }
            }
        }
    }

    private func buildPokerCardViewAt(_ index: Int) -> some View {
        return PokerCardView(
            value: "\(self.possibleEstimates[index])",
            isCardSelected: self.selectedCardIndex == index
            // isCardSelected: (self.draggedCardIndex == index && self.isDraggedOverThreshold()) || self.selectedCardIndex == index
        )
        .rotationEffect(
            Angle(
                degrees: self.calculateAngle(
                    index,
                    totalCards: self.possibleEstimates.count,
                    isCardDragged: self.draggedCardIndex == index
                )
            ),
            anchor: .bottom
        )
        .offset(self.draggedCardIndex == index ? self.offset : .zero)
        .opacity(self.draggedCardIndex == index ? 0.95 : 1.0)
        .animation(.spring())
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.draggedCardIndex = index
                    self.offset = CGSize(
                        width: gesture.translation.width,
                        height: min(0, gesture.translation.height)
                    )
                }
                .onEnded { _ in
                    if self.isDraggedOverThreshold() {
                        self.onEstimate(self.possibleEstimates[index])
                        self.selectedCardIndex = index
                    } else {
                        self.draggedCardIndex = nil
                        self.offset = .zero
                    }
                }
        )
    }

    private func calculateAngle(_ index: Int, totalCards: Int, isCardDragged: Bool = false) -> Double {
        let fraction = abs(self.offset.height) > self.threshold ?
            1.0 :
            abs(Double(self.offset.height)) / Double(self.threshold)
        
        let adjustedFraction = !isCardDragged ? 1.0 : fraction
        let middleCardIndex = Int(floor(Double(totalCards) / 2.0))

        if index < middleCardIndex {
            return Double(middleCardIndex - index) * self.degree * -1.0 * adjustedFraction
        }

        if index > middleCardIndex {
            return Double(index - middleCardIndex) * self.degree * adjustedFraction
        }

        return 0
    }

    private func isDraggedOverThreshold() -> Bool {
        return abs(self.offset.height) > self.threshold
    }
}

struct PokerCardDeckView_Previews: PreviewProvider {
    static var previews: some View {
        PokerCardDeckView(
            onEstimate: { _ in },
            currentTaskName: "Please estimate this very long task"
        )
    }
}
