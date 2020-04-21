//
//  AppDelegate.swift
// AlarmClock
//
//  Created by Aleksandr on 11.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var applicationFlowCoordinator: ApplicationFlowCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        applicationFlowCoordinator = ApplicationFlowCoordinator(window: window)
        applicationFlowCoordinator.execute()
        
        self.window = window
        
        return true
    }
}
