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

    @Binding var roomName: String
    @Binding var participantName: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Participants")
                    .font(.headline)

                HStack {
                    ScrollView(.horizontal) {
                        HStack {
                            UserAvatarView(
                                name: participantName,
                                backgroundColor: Color.blue
                            )

                            ForEach(store.state.otherParticipants) { participant in
                                UserAvatarView(name: participant.name)
                            }
                        }.frame(minWidth: 50, minHeight: 50)
                    }
                }

                Divider()

                Text("You are: \(participantName)")
                Spacer()
            }
        }
        .onAppear {
            self.store.joinRoom(self.roomName, participantName: self.participantName)
        }
        .padding()
        .navigationBarTitle(self.roomName)
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(
            roomName: .constant("foo"),
            participantName: .constant("Test")
        ).environmentObject(Store())
    }
}
