//
//  RoomView.swift
//  PlanningPoker
//
//  Created by Edward Byne on 16/01/2020.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct RoomView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Participants")
                .font(.headline)
            
            HStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(store.participants) { participant in
                            Text(participant.name)
                                .font(.caption)
                        }
                    }
                }
            }

            Divider()
            
            Text("Foo")
            Spacer()

        }
        .padding()
        .navigationBarTitle("Poker Room")
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView().environmentObject(Store())
    }
}
