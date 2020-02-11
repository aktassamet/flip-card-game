//
//  AppDelegate.swift
//  Flip_Card_Game
//
//  Created by samet on 13.03.2019.
//  Copyright © 2019 Fundev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		setupApplication()
		return true
	}

}

// MARK: - Actions
private extension AppDelegate {

	func setupApplication() {
		window = UIWindow.init(frame: UIScreen.main.bounds)
		window?.rootViewController = MemoryGameViewController(.medium)
		window?.makeKeyAndVisible()
	}

}
