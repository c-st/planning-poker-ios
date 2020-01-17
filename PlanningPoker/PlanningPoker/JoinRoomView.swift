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
    @State var participantName: String

    @EnvironmentObject var store: Store

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Join an estimation session")) {
                    TextField("Room", text: self.$roomName)
                    TextField("Your name", text: self.$participantName)
                }

                Section {
                    if !roomName.isEmpty && !participantName.isEmpty {
                        Text("You have chosen room: \(self.roomName)")
                    }

                    //
                    NavigationLink(
                        destination: RoomView(
                            roomName: self.$roomName,
                            participantName: self.$participantName)) {
                        Text("Join the room")
                    }
                    .disabled(roomName.isEmpty || participantName.isEmpty)
                }
            }
            .navigationBarTitle("Planning Poker")
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JoinRoomView(participantName: "Jane Doe")
        // .colorScheme(.dark)
    }
}
