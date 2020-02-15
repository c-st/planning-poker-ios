//
//  ContentView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 16.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct JoinRoomView: View {
    @State var roomName: String
    @State var participantName: String
    @State var isSpectator: Bool = false
    @State var isShowCats: Bool = true

    @State var shouldNavigateToRoom: Bool = false

    @EnvironmentObject var store: Store

    var body: some View {
        Form {
            Section(header: Text("Start or join a new session")) {
                TextField("Room", text: self.$roomName)
                    .accessibility(identifier: "roomTextField")

                TextField("Your name", text: self.$participantName)
                    .accessibility(identifier: "nameTextField")

            }
            Section {
                Toggle(isOn: self.$isSpectator) {
                    Text("Join as spectator")
                }
                .accessibility(identifier: "spectatorToggle")

                Toggle(isOn: self.$isShowCats) {
                    Text("Consensus cats")
                }
                .accessibility(identifier: "consensusCatsToggle")
                
                NavigationLink(
                    destination: RoomView(
                        joinRoomData: JoinRoomData(
                            roomName: self.roomName,
                            participantName: self.participantName,
                            isSpectator: self.isSpectator,
                            isShowCats: self.isShowCats
                        )
                    ),
                    isActive: self.$shouldNavigateToRoom
                )
                {
                    HStack {
                        Text("Join the room")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "person.3.fill")
                            .frame(minHeight: 75)
                    }
                }
                .disabled(roomName.isEmpty || participantName.isEmpty)
                .accessibility(identifier: "joinRoomLink")
            }

            Section {
                HStack {
                    Text("JOIN_ROOM_NOTE")
                        .font(.footnote)
                        .frame(minHeight: 150)
                        .lineLimit(nil)

                    Image("cc-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90)
                }
            }
        }
        .navigationBarTitle("Planning Poker")
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .embedInNavigation()
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            JoinRoomView(
                roomName: "MyProject",
                participantName: "Jane Doe"
            )
            JoinRoomView(
                roomName: "MeinProjekt",
                participantName: "Jana Dorr"
            ).environment(\.locale, .init(identifier: "de"))
        }
    }
}
