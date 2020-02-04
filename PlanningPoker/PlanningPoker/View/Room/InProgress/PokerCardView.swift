//
//  PokerCardView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 22/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct PokerCardView: View {
    let value: String
    var isCardSelected: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(isCardSelected ? Color("secondary-red") : Color("primary2"))
                .shadow(radius: isCardSelected ? 5 : 2)
                .overlay(
                    Image("cc-logo-no-text")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .offset(x: 0, y: 13)
                        .opacity(0.18)
                )

            VStack {
                HStack {
                    Text(value)
                        .font(.system(.headline, design: .monospaced))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Text(value)
                        .font(.system(.headline, design: .monospaced))
                        .foregroundColor(Color.white)
                        .rotationEffect(.degrees(180))
                }
            }.padding(5)

            VStack {
                Text(value)
                    .font(.system(size: value.count > 2 ? 70 : 90, weight: .medium, design: .monospaced))
                    .lineLimit(1)
                    .foregroundColor(Color.white)
            }
        }
        .frame(width: 130, height: 190)
    }
}

struct PokerCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokerCardView(value: "10", isCardSelected: false)
            PokerCardView(value: "100", isCardSelected: true)
        }
        .previewLayout(.sizeThatFits)
    }
}
