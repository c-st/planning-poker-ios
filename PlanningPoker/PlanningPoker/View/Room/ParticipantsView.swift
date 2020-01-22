//
//  ParticipantsView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 21.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct ParticipantsView: View {
    let currentParticipant: Participant?
    let otherParticipants: [Participant]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Participants")
                .font(.caption)
                .fontWeight(.bold)

            HStack {
                ScrollView(.horizontal) {
                    HStack {
                        if currentParticipant != nil {
                            UserAvatarView(
                                participant: currentParticipant!,
                                backgroundColor: Color.blue
                            )
                        }

                        ForEach(otherParticipants) { participant in
                            UserAvatarView(participant: participant)
                        }
                    }.frame(minWidth: 50, minHeight: 50)
                }
            }
        }
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantsView(
            currentParticipant: Participant(name: "Bar"),
            otherParticipants: []
        )
    }
}
