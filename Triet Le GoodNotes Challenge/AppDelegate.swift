//
//  AppDelegate.swift
//  Triet Le GoodNotes Challenge
//
//  Created by Triet Le on 30.7.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = ShoppingNoteViewController()
        window!.makeKeyAndVisible()

        if #available(iOS 13.0, *) {
            window!.overrideUserInterfaceStyle = .light
        }

        return true
    }

}

