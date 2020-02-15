//
//  StartEstimationFormView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 21.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct StartEstimationFormView: View {
    @State var newTaskName = ""
    
    var errorMessage: String? = nil
    let onStartEstimation: (String) -> Void

    var body: some View {
        VStack {
            Text("Start new estimation")
                .fontWeight(.bold)
            
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
            .padding()
            .multilineTextAlignment(.center)

            if (errorMessage != nil) {
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text(errorMessage!)
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                }
                .foregroundColor(Color(UIColor.systemRed))
                .transition(.fade)
            }
            
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
                .background(Color("primary1"))
                .cornerRadius(10)
                .shadow(radius: 10)
            }
        }
    }
}

struct StartEstimationFormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartEstimationFormView(
                onStartEstimation: { _ in }
            )
            .previewLayout(.sizeThatFits)
            
            StartEstimationFormView(
                errorMessage: "Something went wrong",
                onStartEstimation: { _ in }
            )
            .previewLayout(.sizeThatFits)
        }
    }
}
