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
                .shadow(radius: 2)
//            RoundedRectangle(cornerRadius: 15)
//                .stroke(Color.gray, lineWidth: 1)
//                .frame(width: 100, height: 160)
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
                    .font(.system(size: 80, weight: .medium, design: .monospaced))
                    .foregroundColor(Color.white)
            }
        }
        .frame(width: 130, height: 190)
    }
}

struct PokerCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokerCardView(value: "5", isCardSelected: false)
            PokerCardView(value: "20", isCardSelected: true)
        }
        .previewLayout(.sizeThatFits)
    }
}
