//
//  SceneDelegate.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 16.01.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import SDWebImage
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let isInUITesting = CommandLine.arguments.contains("--uitesting")

    var window: UIWindow?

    @iCloudUserDefault("roomName", defaultValue: "") var lastRoomName: String
    @iCloudUserDefault("participantName", defaultValue: "") var lastParticipantName: String

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if isInUITesting {
            print("ToDo: initialize mock store")
        }

        // Disable image cache with our custom implementation in order
        // to have changing cat images:
        SDImageCacheConfig.default.memoryCacheClass = ImageCache.self
        SDImageCacheConfig.default.diskCacheClass = ImageCache.self

        let contentView = JoinRoomView(
            roomName: lastRoomName,
            participantName: lastParticipantName
        )
        .environmentObject(Store())

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.tintColor = UIColor(named: "tintColour")
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
