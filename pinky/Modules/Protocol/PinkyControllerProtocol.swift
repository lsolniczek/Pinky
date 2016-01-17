//
//  PinkyControllerProtocol.swift
//  pinky
//
//  Created by Lukasz on 16/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import Foundation
import UIKit

protocol PinkyControllerProtocol {
    func updateViewWithTableData(pinkyData: [PinkyTableData]?)
    func presentNoTableDataAlert()
    
    func updateCellWithImage(image: UIImage, indexPath: NSIndexPath)
}