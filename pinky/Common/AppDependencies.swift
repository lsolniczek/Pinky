//
//  AppDependencies.swift
//  pinky
//
//  Created by Lukasz on 17/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    let pinkyWireframe = PinkyWireframe()
    
    init() {
        configureDependencies()
    }
    
    private func configureDependencies() {
        let pinkyDataStore = PinkyDataStore()
        let pinkyInteractor = PinkyInteractor(pinkyDataStore: pinkyDataStore)
        let pinkyPresenter = PinkyPresenter()
        pinkyPresenter.interactor = pinkyInteractor
        pinkyPresenter.wirefarme = pinkyWireframe
        pinkyInteractor.presenter = pinkyPresenter
        pinkyWireframe.pinkyPresenter = pinkyPresenter
    }
    
    func installMainViewIntoWindow(window: UIWindow) {
        let mainViewController = pinkyWireframe.presentPinkyViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = mainNavigationController
        window.makeKeyAndVisible()
    }
}