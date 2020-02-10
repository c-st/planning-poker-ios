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
    var window: UIWindow?

    let store: Store

    @iCloudUserDefault("roomName", defaultValue: "") var lastRoomName: String
    @iCloudUserDefault("participantName", defaultValue: "") var lastParticipantName: String

    override init() {
        self.store = !UITestingUtils.isInUITest ? Store() : Store(UITestingUtils.stateFixtureBasedOnArguments())

        // Disable image cache with our custom implementation in order to have changing cat images:
        SDImageCacheConfig.default.memoryCacheClass = ImageCache.self
        SDImageCacheConfig.default.diskCacheClass = ImageCache.self

        // Currently this is necessary in order to set the color of Toggles:
        UISwitch.appearance().onTintColor = UIColor(named: "tintColour")
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let initialView = UITestingUtils.isInUITest ? AnyView(
            JoinRoomView(
                roomName: store.state.roomName ?? "",
                participantName: store.state.participant?.name ?? "",
                shouldNavigateToRoom: store.state.roomName != nil && store.state.participant != nil
            )
        ) : AnyView(
            JoinRoomView(
                roomName: lastRoomName,
                participantName: lastParticipantName
            )
        )

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.tintColor = UIColor(named: "tintColour")
            window.rootViewController = UIHostingController(
                rootView: initialView.environmentObject(store)
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        store.rejoinRoom()
    }
}
