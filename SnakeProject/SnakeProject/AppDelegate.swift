//
//  AppDelegate.swift
//  SnakeProject
//
//  Created by Erik Sveningsson on 2019-11-15.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //store best score
        let defaults = UserDefaults.standard
        let defaultValue = ["bestScore": 0]
        defaults.register(defaults: defaultValue)
        
        

        return true
    }
}

