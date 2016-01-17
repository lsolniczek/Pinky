//
//  PinkyWireframe.swift
//  pinky
//
//  Created by Lukasz on 17/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

let pinkyViewControllerIdentifier = "MainViewController"

class PinkyWireframe {
    var pinkyViewController: MainPinkyController?
    var pinkyPresenter: PinkyPresenter?
    
    func presentPinkyViewController() -> MainPinkyController {
        let viewController = pinkyViewControllerFromStoryboard()
        pinkyViewController = viewController
        pinkyViewController?.presenter = pinkyPresenter
        pinkyPresenter?.controller = viewController
        return viewController
    }
    
    func presentWebViewControllerWith(path: String) {
        if let url = NSURL(string: path) as NSURL? {
            let svc = SFSafariViewController(URL: url)
            pinkyViewController?.presentViewController(svc, animated: true, completion: nil)
        }
    }
    
    private func pinkyViewControllerFromStoryboard() -> MainPinkyController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(pinkyViewControllerIdentifier) as! MainPinkyController
        return viewController
    }
    
    private func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard
    }
}