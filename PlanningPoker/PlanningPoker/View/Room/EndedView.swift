//
//  EndedView.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 20.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SwiftUI

struct EndedView: View {
    let onStartEstimation: (String) -> Void

    var body: some View {
        VStack {
            Text("Estimation results...")
            StartEstimationFormView(
                onStartEstimation: onStartEstimation
            )
        }
    }
}

struct EndedView_Previews: PreviewProvider {
    static var previews: some View {
        EndedView(onStartEstimation: { _ in })
    }
}
