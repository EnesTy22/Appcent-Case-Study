//
//  SceneDelegate.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 8.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            
            guard let windowScene = (scene as? UIWindowScene) else { return }
            
            // general foundation working
            // tabbar controller holding navigation controller, holding view controller
            
            let homeNC = createNavigationController(title: "Home", viewContoller: HomeVC(),systemName: "music.note", tag: 0)
            
            let favoriteNC = createNavigationController(title: "Favorite Tracks", viewContoller: FavoritesVC(), systemName: "heart.fill", tag: 1)
       
            
            let tabBar = createTabBar(viewControllers: [homeNC , favoriteNC])
            
          
            UITabBar.appearance().barTintColor = UIColor.white
            
            let appearance = UITabBarAppearance()
            let spotifyGreen = UIColor(red: 30/255.0, green: 215/255.0, blue: 96/255.0, alpha: 1.0)

            
            appearance.backgroundColor = .white
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
            

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance


            // Set the title attributes for the selected state
          
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = tabBar
            window?.makeKeyAndVisible()
        }
        
        func createNavigationController(title: String, viewContoller: UIViewController, systemName: String , tag: Int) -> UINavigationController {
            
            let viewController = viewContoller
            
            viewController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: systemName),tag: tag)
            
            
            return UINavigationController(rootViewController: viewController)
        }
        
        func createTabBar(viewControllers: [UIViewController]) -> UITabBarController {
            let tabBar = UITabBarController()
            UITabBar.appearance().tintColor = .blue
            UITabBar.appearance().backgroundColor = .systemGray
            UITabBar.appearance().unselectedItemTintColor = .white
            tabBar.viewControllers = viewControllers
            return tabBar
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

