//
//  AppDelegate.swift
//  iOS Assignment
//
//  Created by Raju Kumar on 07/09/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //set root controller
        self.setHomeController()
        sleep(2)
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func setHomeController() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "ProductListVC") as? ProductListVC else {
            fatalError("Storyboard does not contain the view controller...")
        }
        
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        nav.interactivePopGestureRecognizer?.isEnabled = true
        
        // Check if the window property is not nil before using it
        if let window = self.window {
            UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut) {
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }
        } else {
            fatalError("Window is nil")
        }
    }
}

