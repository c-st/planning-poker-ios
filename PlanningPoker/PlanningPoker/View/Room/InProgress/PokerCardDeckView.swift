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
    let degree: Int = 12

    let possibleEstimates: [String] = [
        "0", "1", "2", "3",
        "5", "8", "13", "20",
        "40", "100", "???"
    ].reversed()

    @State private var offset = CGSize.zero
    @State private var draggedCardIndex: Int? = nil

    let onEstimate: (String) -> Void
    var currentTaskName: String

    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    Text(self.currentTaskName)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 80, leading: 50, bottom: 80, trailing: 50))
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
//                .background(Color.red)
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
            isCardSelected: self.draggedCardIndex == index && self.isDraggedOverThreshold()
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
        .opacity(self.draggedCardIndex == index ? 0.9 : 1.0)
        .animation(.spring())
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.draggedCardIndex = index
                    self.offset = gesture.translation
                }
                .onEnded { _ in
                    if self.isDraggedOverThreshold() {
                        self.onEstimate(self.possibleEstimates[index])
                    } else {
                        self.draggedCardIndex = nil
                        self.offset = .zero
                    }
                }
        )
    }

    private func calculateAngle(_ index: Int, totalCards: Int, isCardDragged: Bool = false) -> Double {
        let percent = !isCardDragged ? Int(1) : Int(floor(abs(self.offset.height) / self.threshold))

        let middleCardIndex = Int(floor(Double(totalCards) / Double(2)))

        if index < middleCardIndex {
            return Double((middleCardIndex - index) * self.degree * -1 * percent)
        }

        if index > middleCardIndex {
            return Double((index - middleCardIndex) * self.degree * percent)
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
