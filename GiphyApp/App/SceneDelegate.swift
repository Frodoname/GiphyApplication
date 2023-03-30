//
//  SceneDelegate.swift
//  GiphyApp
//
//  Created by Fed on 25.03.2023.
//
// swiftlint:disable line_length

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let mainViewController = MainViewController()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: mainViewController)
        self.window = window
        window.makeKeyAndVisible()
    }
}
