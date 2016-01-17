//
//  PinkyInteractorProtocol.swift
//  pinky
//
//  Created by Lukasz on 16/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import Foundation

protocol PinkyInteractorProtocol {
    func fetchDataFromDB()
    func removeDataFromDB()
    
    func fetchDataFromApi()
    
    func fetchImageWith(pinkyTableData: PinkyTableData, indexPath: NSIndexPath)
}