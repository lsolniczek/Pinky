//
//  PinkyDataStore.swift
//  pinky
//
//  Created by Lukasz on 16/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import Foundation
import RealmSwift

class PinkyDataStore {
    
    let realm = try! Realm()
    
    func requestPinkyData() -> [PinkyTableData]? {
        let pinkyData = realm.objects(PinkyModel).sorted("orderId")
        guard pinkyData.count > 0 else { return nil }
        return pinkyTableDataFromPinkyData(pinkyData)
    }
    
    func pinkyTableDataFromPinkyData(pinkyData: Results<PinkyModel>) -> [PinkyTableData] {
        var pinkyDataCollection = [PinkyTableData]()
        for data in pinkyData {
            pinkyDataCollection.append(PinkyTableData(orderId: data.orderId, title: data.title, description: data.desc, imageURL: data.imageURL, image: nil, isImageDownloaded: false, url: data.url, modificationDate: data.modificationDate))
        }
        return pinkyDataCollection
    }
    
    func cratePinkyModelsWithJSON(pinkyRawData: [[String: AnyObject]]) {
        for pinkyData in pinkyRawData {
            let pinkyModel = PinkyModel()
            pinkyModel.updateWith(pinkyData)
            try! realm.write({
                realm.add(pinkyModel)
            })
        }
    }
    
    func removePinkyDataFromDB() {
        try! realm.write({
            realm.deleteAll()
        })
    }
}