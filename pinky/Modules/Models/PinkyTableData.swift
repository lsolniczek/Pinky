//
//  PinkyTableData.swift
//  pinky
//
//  Created by Lukasz on 16/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import Foundation
import UIKit

class PinkyTableData {
    var orderId: Int
    var title: String
    var description: String
    var imageURL: String
    var image: UIImage?
    var isImageDownloaded: Bool
    var url: String
    var modificationDate: String
    
    init(orderId: Int, title: String, description: String, imageURL: String, image: UIImage?, isImageDownloaded: Bool, url: String, modificationDate: String) {
        self.orderId = orderId
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.image = image
        self.isImageDownloaded = isImageDownloaded
        self.url = url
        self.modificationDate = modificationDate
    }
}