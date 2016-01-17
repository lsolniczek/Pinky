//
//  AppDelegate.swift
//  pinky
//
//  Created by Lukasz on 16/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appDependencies = AppDependencies()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        appDependencies.installMainViewIntoWindow(self.window!)
        
        return true
    }
}

