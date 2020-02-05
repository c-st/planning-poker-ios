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
    @State var isShowCats: Bool = true

    @EnvironmentObject var store: Store

    var body: some View {
        // Currently this is necessary in order to set the color of Toggles:
        UISwitch.appearance().onTintColor = UIColor(named: "tintColour")
        
        return NavigationView {
            Form {
                Section(header: Text("Join an estimation session")) {
                    TextField("Room", text: self.$roomName)
                        .accessibility(identifier: "roomTextField")

                    TextField("Your name", text: self.$participantName)
                        .accessibility(identifier: "nameTextField")

                    Toggle(isOn: self.$isShowCats) {
                        Text("Consensus cats")
                    }
                }

                Section {
                    NavigationLink(
                        destination: RoomView(
                            joinRoomData: JoinRoomData(
                                roomName: self.roomName,
                                participantName: self.participantName,
                                isShowCats: self.isShowCats
                            )
                        )
                    )
                    {
                        Text("Join the room")
                    }
                    .disabled(roomName.isEmpty || participantName.isEmpty)
                    .accessibility(identifier: "joinRoomLink")
                }

                Section {
                    HStack {
                        Spacer()
                        Image("cc-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Planning Poker")
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            JoinRoomView(
                roomName: "My Project",
                participantName: "Jane Doe"
            )
            JoinRoomView(
                roomName: "Mein Projekt",
                participantName: "Jana Dorr"
            ).environment(\.locale, .init(identifier: "de"))
        }
    }
}
