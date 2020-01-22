//
//  NewInProgressView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 22/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct PokerCardDeckView<Content: View>: View {
    let threshold: CGFloat = 100

    let content: Content

    init(onEstimate: @escaping (String) -> Void, @ViewBuilder content: () -> Content) {
        self.onEstimate = onEstimate
        self.content = content()
    }
    
    let possibleEstimates = [
        "0", "1", "2", "3",
        "5", "8", "13", "20",
        "40", "100", "???"
    ]
    
    @State private var offset = CGSize.zero
    @State private var draggedCardIndex = 0

    let onEstimate: (String) -> Void

    var body: some View {
        ZStack {
            VStack {
                content
                ZStack {
                    ForEach(0..<possibleEstimates.count, id: \.self) { index in
                        self.buildPokerCardViewAt(index)
                    }
                }
            }
        }
    }

    private func buildPokerCardViewAt(_ index: Int) -> some View {
        return PokerCardView(value: "\(self.possibleEstimates[index])")
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
                        if abs(self.offset.height) > self.threshold {
                            self.onEstimate(self.possibleEstimates[index])
                        } else {
                            self.offset = .zero
                        }
                    }
            )
    }

    private func calculateAngle(_ index: Int, totalCards: Int, isCardDragged: Bool = false) -> Double {
        let percent = !isCardDragged ? Int(1) : Int(floor(abs(self.offset.height) / self.threshold))

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

struct PokerCardDeckView_Previews: PreviewProvider {
    static var previews: some View {
        PokerCardDeckView(onEstimate: { _ in }) {
            Text("Implement the card swipe view ")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(20)
                .opacity(0.4)
        }
    }
}
