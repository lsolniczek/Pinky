//
//  PinkyPresenterProtocol.swift
//  pinky
//
//  Created by Lukasz on 16/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import Foundation
import UIKit

protocol PinkyPresenterProtocol {
    func requestNewContent()
    
    func requestTableData()
    func respondWithTableData(pinkyData: [PinkyTableData]?)
    
    func requestCellImageWith(pinkyData: PinkyTableData, indexPath: NSIndexPath)
    func responseCellImageWith(image: UIImage?, indexPath: NSIndexPath)
    
    func openWebViewWith(pinkyData: PinkyTableData)
}