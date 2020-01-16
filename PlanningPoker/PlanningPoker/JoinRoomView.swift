//
//  ContentView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 16.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct JoinRoomView: View {
    @State var roomName: String = ""
    @EnvironmentObject var store: Store

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Room")) {
                    TextField("Name", text: self.$roomName)
                }

                Section {
                    if !roomName.isEmpty {
                        Text("You have chosen room: \(self.roomName)")
                    }

                    NavigationLink(destination: RoomView()) {
                        Text("Join the room")
                    }
                    .disabled(roomName.isEmpty)
                }
            }
            .navigationBarTitle("Planning Poker")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JoinRoomView()
        // .colorScheme(.dark)
    }
}
