//
//  NotYetStartedView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 20.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct NotYetStartedView: View {
    let onStartEstimation: (String) -> Void

    var body: some View {
        VStack {
            StartEstimationFormView(
                onStartEstimation: onStartEstimation
            )
            Spacer()
        }
        .cornerRadius(10)
        .padding()
    }
}

struct NotYetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        NotYetStartedView(
            onStartEstimation: { _ in print("Start estimating!") }
        ).previewLayout(.fixed(width: 350.0, height: 230.0))
    }
}
