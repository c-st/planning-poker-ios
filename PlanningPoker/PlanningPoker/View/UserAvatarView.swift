//
//  UserAvatarView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 17.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct UserAvatarView: View {
    var participant: Participant
    var backgroundColor: Color = Color("primary2")

    var body: some View {
        Text(participant.name)
            .font(.caption)
            .fontWeight(.semibold)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .frame(width: 60, height: 60)
            .padding(5)
            .background(participant.hasEstimated ? Color("secondary-red") : backgroundColor)
            .foregroundColor(Color.white)
            .clipShape(Circle())
    }
}

struct UserAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            UserAvatarView(participant: Participant(name: "Edward", hasEstimated: false))
            UserAvatarView(participant: Participant(name: "Christian S.", hasEstimated: false))
            UserAvatarView(participant: Participant(name: "Christian L.", hasEstimated: false))
            UserAvatarView(participant: Participant(name: "Herr Doktor Oberhagemann", hasEstimated: true))
        }
    }
}
