//
//  SceneDelegate.swift
//  MarvelComics
//
//  Created by Filipe Cruz on 06/12/20.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      let containerView = ContainerView(viewModel: HeroesListViewModel())

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: containerView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

