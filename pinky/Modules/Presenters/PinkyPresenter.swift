//
//  PinkyPresenter.swift
//  pinky
//
//  Created by Lukasz on 16/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import Foundation
import UIKit

class PinkyPresenter: PinkyPresenterProtocol {
    
    var controller: PinkyControllerProtocol?
    var interactor: PinkyInteractorProtocol?
    var wirefarme: PinkyWireframe?
    
    // MARK: - Request/Response for Content
    func requestTableData() {
        interactor?.fetchDataFromDB()
    }
    
    func requestNewContent() {
        interactor?.removeDataFromDB()
        interactor?.fetchDataFromApi()
    }
    
    func respondWithTableData(pinkyData: [PinkyTableData]?) {
        if let pinkyData = pinkyData as [PinkyTableData]? {
            controller?.updateViewWithTableData(pinkyData)
        } else {
            controller?.presentNoTableDataAlert()
        }
    }
    
    // MARK: - Request/Response Image for Cell
    func requestCellImageWith(pinkyData: PinkyTableData, indexPath: NSIndexPath) {
        if !pinkyData.isImageDownloaded {
            interactor?.fetchImageWith(pinkyData, indexPath: indexPath)
        }
    }
    
    func responseCellImageWith(image: UIImage?, indexPath: NSIndexPath) {
        if let image = image as UIImage? {
            controller?.updateCellWithImage(image, indexPath: indexPath)
        }
    }
    
    // MARK: - Present Web
    func openWebViewWith(pinkyData: PinkyTableData) {
        wirefarme?.presentWebViewControllerWith(pinkyData.url)
    }
}