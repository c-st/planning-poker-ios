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

    @State var joinRoomData: JoinRoomData
    @State var newTaskName: String = ""

    var body: some View {
        ScrollView {
            VStack {
                Text("Participants")
                    .font(.headline)

                ParticipantsView(
                    currentParticipant: store.state.participant,
                    otherParticipants: store.state.otherParticipants
                )

                Divider()

                if store.state.estimationStatus == .notStarted {
                    NotYetStartedView(
                        newTaskName: self.$newTaskName,
                        onStartEstimation: { self.store.sendStartEstimationRequestFor(self.newTaskName) }
                    )
                }

                if store.state.estimationStatus == .inProgress {
                    InProgressView(
                        onEstimate: { self.store.sendEstimate($0) },
                        onShowResult: { self.store.sendEstimationResultRequest() }
                    )
                }

                if store.state.estimationStatus == .ended {
                    EndedView()
                }
            }
            .padding()
            .navigationBarTitle(self.joinRoomData.roomName)
            .onAppear { self.store.joinRoom(self.joinRoomData) }
            .onDisappear { self.store.leaveRoom() }
        }
    }
}

//    var body: some View {
//        ScrollView {
//            VStack { // (alignment: .leading) {
//                Text("Participants")
//                    .font(.headline)
//
//                ParticipantsView(
//                    currentParticipant: store.state.participant!,
//                    otherParticipants: store.state.otherParticipants
//                )
//
/// /                Divider()
//

//            }
//        }

// .padding()
// .navigationBarTitle(self.roomName)
//    }
// }

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(
            joinRoomData: JoinRoomData(
                roomName: "Room",
                participantName: "Foo"
            )
        ).environmentObject(Store())
    }
}
