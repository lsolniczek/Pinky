//
//  PinkyModel.swift
//  pinky
//
//  Created by Lukasz on 17/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import Foundation
import RealmSwift

class PinkyModel: Object {
    dynamic var orderId: Int = 0
    dynamic var title: String = ""
    dynamic var desc: String = ""
    dynamic var imageURL: String = ""
    dynamic var url: String = ""
    dynamic var modificationDate: String = ""
    
    func updateWith(json: [String: AnyObject]) {
        let (desc, url) = PinkyModel.sliceDescription(json["description"] as! String)
        self.desc = desc
        self.url = url
        self.orderId = json["orderId"] as! Int
        self.title = json["title"] as! String
        self.imageURL = json["image_url"] as! String
        self.modificationDate = json["modificationDate"] as! String
    }
}

extension PinkyModel {
    
    static func sliceDescription(description: String) -> (String, String) {
        let desc = (description as NSString)
        let pattern = "https?://(?:www\\.)?\\S+(?:/|\\b)"
        
        let expresion = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        let descRange = desc.rangeOfString(description)
        let urlRange = expresion.rangeOfFirstMatchInString(description, options: .ReportProgress, range: descRange)
        
        return (desc.substringToIndex(urlRange.location), desc.substringFromIndex(urlRange.location))
    }
}