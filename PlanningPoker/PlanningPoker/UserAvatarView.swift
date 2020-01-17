//
//  UserAvatarView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 17.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct UserAvatarView: View {
    var name: String
    var backgroundColor: Color = Color.black

    var body: some View {
        Text(name)
            .font(.caption)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .frame(width: 50, height: 50)
            .background(backgroundColor)
            .foregroundColor(Color.white)
            .clipShape(Circle())
    }
}

struct UserAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        UserAvatarView(name: "Some user")
    }
}
