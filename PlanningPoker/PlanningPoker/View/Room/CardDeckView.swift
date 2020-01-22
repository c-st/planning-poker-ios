//
//  NewInProgressView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 22/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct CardDeckView: View {
    static let threshold: CGFloat = 100

    let possibleEstimates = ["0", "1", "2", "3", "5", "8", "13", "20", "40", "100", "???"]

    @State private var offset = CGSize.zero
    @State private var draggedCardIndex = 0

    var currentTaskName: String?
//    var participantEstimate: String? // show initial estimate?
    let onEstimate: (String) -> Void

    var body: some View {
        ZStack {
            VStack {
                if currentTaskName != nil {
                    Text("\(currentTaskName!)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
                        .opacity(0.6)
                }

                ZStack {
                    ForEach(0..<possibleEstimates.count, id: \.self) { index in
                        PokerCardView(value: self.possibleEstimates[index])
                            .opacity(self.draggedCardIndex == index ? 0.9 : 1.0)
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
                            .animation(.spring())
                            .offset(self.draggedCardIndex == index ? self.offset : .zero)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        self.draggedCardIndex = index
                                        self.offset = gesture.translation
                                    }
                                    .onEnded { _ in
                                        if abs(self.offset.height) > CardDeckView.threshold {
                                            self.onEstimate(self.possibleEstimates[index])
                                        } else {
                                            self.offset = .zero
                                        }
                                    }
                            )
                    }
                }
            }
        }
    }

    private func calculateAngle(_ index: Int, totalCards: Int, isCardDragged: Bool = false) -> Double {
        let percent = !isCardDragged ? Int(1) : Int(floor(abs(self.offset.height) / CardDeckView.threshold))

        let middleCardIndex = Int(floor(Double(totalCards) / Double(2)))

        if index < middleCardIndex {
            return Double((middleCardIndex - index) * -10 * percent)
        }

        if index > middleCardIndex {
            return Double((index - middleCardIndex) * 10 * percent)
        }

        return 0
    }
}

struct CardDeckView_Previews: PreviewProvider {
    static var previews: some View {
        CardDeckView(
            currentTaskName: "Foo",
//            participantEstimate: "5",
            onEstimate: { _ in }
//            onShowResult: {}
        )
    }
}
