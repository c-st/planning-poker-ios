//
//  SceneDelegate.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 16.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let isInUITesting = CommandLine.arguments.contains("--uitesting")
    
    var window: UIWindow?
    
    @iCloudUserDefault("participantName", defaultValue: "") var lastParticipantName: String
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if isInUITesting {
            print("ToDo: initialize mock store")
        }
        
        let contentView = JoinRoomView(
            participantName: lastParticipantName)
            .environmentObject(Store())

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

