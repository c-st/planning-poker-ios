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
    @State var participantName: String = ""
    @State var navigationSelection: Int? = nil

    @EnvironmentObject var store: Store

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Join an estimation session")) {
                    TextField("Room", text: self.$roomName)
                        .accessibility(identifier: "roomTextField")

                    TextField("Your name", text: self.$participantName)
                        .accessibility(identifier: "nameTextField")
                }

                Section {
                    NavigationLink(
                        destination: RoomView(
                            joinRoomData: JoinRoomData(
                                roomName: self.roomName,
                                participantName: self.participantName
                            )
                        )
                    )
                    {
                        Text("Join the room")
                    }
                    .disabled(roomName.isEmpty || participantName.isEmpty)
                    .accessibility(identifier: "joinRoomLink")
                }
            }
            .navigationBarTitle("Planning Poker")
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JoinRoomView(participantName: "Jane Doe")
        // .colorScheme(.dark)
    }
}
