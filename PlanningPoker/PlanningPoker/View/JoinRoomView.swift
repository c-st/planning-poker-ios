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
            Section(header: Text("JOIN_ROOM_HEADER")) {
                HStack {
                    TextField("Room name", text: self.$roomName)
                        .accessibility(identifier: "roomTextField")
                        
                    buildCheckmarkView()
                        .hidden(roomName.count < 3)
                }

                HStack {
                    TextField("Your name", text: self.$participantName)
                        .accessibility(identifier: "nameTextField")
                    
                    buildCheckmarkView()
                        .hidden(participantName.count < 1)
                }
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
                            .frame(minHeight: 60)
                    }
                }
                .disabled(!canJoinRoom(
                    roomName: roomName,
                    participantName: participantName)
                )
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
    
    private func buildCheckmarkView() -> some View {
        Image(systemName: "checkmark.circle.fill")
            .foregroundColor(Color("tintColour"))
            .opacity(0.7)
            .transition(AnyTransition.scale.animation(.spring()))
    }
    
    private func canJoinRoom(roomName: String, participantName: String) -> Bool {
        let allowedCharactersRegex = try! NSRegularExpression(
            pattern: "[a-zA-Z0-9-]{3,}"
        )
        let roomNameMatched = allowedCharactersRegex.firstMatch(
            in: roomName,
            options: [],
            range: NSRange(location: 0, length: roomName.utf16.count)
        ) != nil
        
        return !roomName.isEmpty && !participantName.isEmpty && roomNameMatched
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            JoinRoomView(
                roomName: "M",
                participantName: ""
            )
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
