//
//  StartEstimationFormView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 21.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct StartEstimationFormView: View {
    @State var newTaskName: String = ""
    let onStartEstimation: (String) -> Void

    var body: some View {
        VStack {
            ZStack {
                if self.newTaskName.isEmpty {
                    Text("Enter task")
                        .foregroundColor(Color(UIColor.systemGray))
                        .opacity(0.5)
                }
                TextField("", text: self.$newTaskName)
            }
            .frame(minHeight: 40)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding(.vertical)
            .multilineTextAlignment(.center)

            VStack(alignment: .center) {
                Button(action: { self.onStartEstimation(self.newTaskName) }) {
                    Image(systemName: "play.fill")
                    Text("Start")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                .disabled(newTaskName.isEmpty)
                .frame(minWidth: 100)
                .padding(15)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 10)
            }
        }
    }
}

struct StartEstimationFormView_Previews: PreviewProvider {
    static var previews: some View {
        StartEstimationFormView(
            onStartEstimation: { _ in }
        )
        .previewLayout(.sizeThatFits)
        .colorScheme(.dark)
    }
}
