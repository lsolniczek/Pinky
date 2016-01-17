//
//  PinkyInteractor.swift
//  pinky
//
//  Created by Lukasz on 16/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import Foundation
import UIKit

class PinkyInteractor: PinkyInteractorProtocol {
    
    var presenter: PinkyPresenterProtocol?
    var pinkyDataStore: PinkyDataStore
    
    init(pinkyDataStore: PinkyDataStore) {
        self.pinkyDataStore = pinkyDataStore
    }
    
    func fetchDataFromDB() {
        let pinkyTableData = pinkyDataStore.requestPinkyData()
        self.presenter?.respondWithTableData(pinkyTableData)
    }
    
    func removeDataFromDB() {
        pinkyDataStore.removePinkyDataFromDB()
    }
    
    func fetchDataFromApi() {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        if let url = NSURL(string: "http://pinky.futuremind.com/~dpaluch/test35/") as NSURL? {
            let task = session.dataTaskWithURL(url) { data, response, error in
                if let _ = error as NSError? {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presenter?.respondWithTableData(nil)
                        return
                    })
                }
                if let data = data as NSData? {
                    do {
                        let jsonDic = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
                        let pinkyRawData = jsonDic["data"] as! [[String: AnyObject]]
                        dispatch_async(dispatch_get_main_queue(), {
                            self.pinkyDataStore.cratePinkyModelsWithJSON(pinkyRawData)
                            self.presenter?.requestTableData()
                        })
                    } catch {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.presenter?.respondWithTableData(nil)
                        })
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchImageWith(pinkyTableData: PinkyTableData, indexPath: NSIndexPath) {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        if let url = NSURL(string: pinkyTableData.imageURL) as NSURL? {
            let task = session.downloadTaskWithURL(url, completionHandler: { tempLocation, response, error in
                if let _ = error as NSError? {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presenter?.responseCellImageWith(nil, indexPath: indexPath)
                        return
                    })
                }
                if let tempLocation = tempLocation as NSURL?, let imageData = NSData(contentsOfURL: tempLocation) as NSData? {
                    let image = UIImage(data: imageData)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presenter?.responseCellImageWith(image, indexPath: indexPath)
                    })
                } else {
                    self.presenter?.responseCellImageWith(nil, indexPath: indexPath)
                }
            })
            task.resume()
        }
    }
}