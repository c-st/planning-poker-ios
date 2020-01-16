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
            Text("In the room")
//            List(store.participants) { participant in
//                Text(participant.name)
//            }.navigationBarTitle("Poker Room")
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView().environmentObject(Store())
    }
}
