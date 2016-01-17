//
//  MainPinkyController.swift
//  pinky
//
//  Created by Lukasz on 16/01/16.
//  Copyright © 2016 Lukasz. All rights reserved.
//

import UIKit

let mainPinkyCellIdentifier = "PinkyCell"

class MainPinkyController: UITableViewController {

    var presenter: PinkyPresenterProtocol?
    var tableData: [PinkyTableData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: "fetchCollection", forControlEvents: .ValueChanged)
        refresh()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableData = tableData as [PinkyTableData]? {
            return tableData.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(mainPinkyCellIdentifier) as! PinkyCell
        if let tableData = tableData as [PinkyTableData]? {
            let pinkyData = tableData[indexPath.row]
            cell.title.text = pinkyData.title
            cell.modificationDate.text = pinkyData.modificationDate
            cell.desc.text = pinkyData.description
            cell.cellImage.image = pinkyData.image
            
            if !pinkyData.isImageDownloaded {
                presenter?.requestCellImageWith(pinkyData, indexPath: indexPath)
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let pinkyData = tableData![indexPath.row]
        presenter?.openWebViewWith(pinkyData)
    }
    
    // MARK: - Refresh Controller methods
    func fetchCollection() {
        presenter?.requestNewContent()
    }
    
    func refresh() {
        self.refreshControl?.beginRefreshing()
        self.tableView.setContentOffset(CGPointMake(0.0, -self.refreshControl!.bounds.size.height), animated: true)
        presenter?.requestTableData()
    }
}


extension MainPinkyController: PinkyControllerProtocol {
    
    func updateViewWithTableData(pinkyData: [PinkyTableData]?) {
        tableData = pinkyData
        self.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func presentNoTableDataAlert() {
        let alert = UIAlertController(title: "No Content", message: "Sorry, there is no content for you.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default) { action in
            self.refreshControl?.endRefreshing()
        }
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateCellWithImage(image: UIImage, indexPath: NSIndexPath) {
        let pinkyData = tableData![indexPath.row]
        pinkyData.image = image
        pinkyData.isImageDownloaded = true
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
    }
}