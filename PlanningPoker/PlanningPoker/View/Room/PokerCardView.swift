//
//  PokerCardView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 22/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct PokerCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.green)
                .shadow(radius: 2)

            Text("5")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
        }
        .frame(width: 150, height: 250)
    }
}

struct PokerCardView_Previews: PreviewProvider {
    static var previews: some View {
        PokerCardView()
    }
}
