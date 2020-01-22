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

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ParticipantsView(
                    currentParticipant: store.state.participant,
                    otherParticipants: store.state.otherParticipants
                )

                Divider()

                if store.state.estimationStatus == .notStarted {
                    NotYetStartedView(
                        onStartEstimation: { self.store.sendStartEstimationRequestFor($0) }
                    )
                }

                if store.state.estimationStatus == .inProgress {
                    InProgressView(
                        currentTaskName: self.store.state.currentTaskName,
                        participantEstimate: self.store.state.participant!.currentEstimate,
                        onEstimate: { self.store.sendEstimate($0) },
                        onShowResult: { self.store.sendEstimationResultRequest() }
                    )
                }

                if store.state.estimationStatus == .ended {
                    EndedView(
                        participants: self.store.state.otherParticipants + [self.store.state.participant!],
                        onStartEstimation: { self.store.sendStartEstimationRequestFor($0) }
                    )
                }
            }
            .padding()
            .navigationBarTitle(self.joinRoomData.roomName)
            .onAppear { self.store.joinRoom(self.joinRoomData) }
            .onDisappear { self.store.leaveRoom() }
        }
    }
}

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
