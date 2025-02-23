//
//  SceneDelegate.swift
//  travel
//
//  Created by Lin Jin on 9/3/24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // 1. Capture the scene
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        
//        // 2. Create a new UIWindow and pass in a UIWindowScene
//        let window = UIWindow(windowScene: windowScene)
//        
//        // 3. Create a view hierarchy programmatically
//        // HERE IS THE INITIAL VIEW
////        let initialSwiftUIView = WelcomeController1()
////        let navController = UINavigationController(rootViewController: initialSwiftUIView)
//        
//        let initialSwiftUIView = OnboardingProfile()
//        let hostingController = UIHostingController(rootView: initialSwiftUIView)
//        let navController = UINavigationController(rootViewController: hostingController)
//        
//        navController.navigationBar.isHidden = true
//        
//        // 4. Set the navigation controller as the window's root view controller
//        window.rootViewController = navController
//        
//        // 5. Set the window and call makeKeyAndVisible()
//        self.window = window
//        window.makeKeyAndVisible()
//    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1. Capture the scene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 2. Create a new UIWindow and pass in a UIWindowScene
        let window = UIWindow(windowScene: windowScene)
        
        // 3. Create a SwiftUI view that includes NavigationStack
        let initialSwiftUIView = OnboardingProfile() // Your initial SwiftUI view
        
        // Use a UIHostingController with the SwiftUI view
        let hostingController = UIHostingController(rootView: initialSwiftUIView)
        
        // 4. Set the rootViewController directly to the hostingController
        window.rootViewController = hostingController
        
        // 5. Set the window and call makeKeyAndVisible()
        self.window = window
        window.makeKeyAndVisible()
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

