//
//  SceneDelegate.swift
//  ATMFinder
//
//  Created by Valter Machado on 3/31/24.
//

import UIKit
import OverlayContainer

enum OverlayNotch: Int, CaseIterable {
    case minimum, medium, maximum
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    var window: UIWindow?
    let containerController = OverlayContainerViewController()
    let mapsController = MapViewController()
    let searchController: SearchViewController = {
        let searchVC = SearchViewController()
        searchVC.view.roundTopLeftAndRightCorners(radius: 30.0)
        return searchVC
    }()
    
    // MARK: - SceneDelegate Methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        containerController.delegate = self
        containerController.viewControllers = [
            mapsController,
            searchController
        ]
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = containerController
        window.makeKeyAndVisible()
        self.window = window
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

// MARK: - OverlayContainerViewControllerDelegate
extension SceneDelegate: OverlayContainerViewControllerDelegate {
    
    // Enables searchController have an uniform scrolling with its tableView
    func overlayContainerViewController(
        _ containerViewController: OverlayContainerViewController,
        scrollViewDrivingOverlay overlayViewController: UIViewController
    ) -> UIScrollView? {
        return (overlayViewController as? SearchViewController)?.tableView
    }
    
    // numberOfNotches
    func numberOfNotches(in containerViewController: OverlayContainer.OverlayContainerViewController) -> Int {
        return OverlayNotch.allCases.count
    }
    
    // heightForNotchAt
    func overlayContainerViewController(_ containerViewController: OverlayContainer.OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        if let screenFrame = self.window?.safeAreaLayoutGuide.layoutFrame {
            switch OverlayNotch.allCases[index] {
            case .maximum:
                return availableSpace - (screenFrame.minY + 5)
            case .medium:
                return availableSpace / 2
            case .minimum:
                return availableSpace * 1 / 5
            }
        }
        return -1.0
    }

}

