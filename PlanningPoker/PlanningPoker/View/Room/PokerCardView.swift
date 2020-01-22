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

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.green)
                .shadow(radius: 2)
            VStack {
                HStack {
                    Text(value)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                }
                Spacer()
            }.padding(5)
            VStack {
                Text(value)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
        }
        .frame(width: 130, height: 190)
    }
}

struct PokerCardView_Previews: PreviewProvider {
    static var previews: some View {
        PokerCardView(value: "5")
    }
}
