//
//  FileTableViewController.swift
//  ReadFile
//
//  Created by Thong Hao Yi on 31/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class FileTableViewController: UITableViewController {

    let cellIdentifier = "UITableViewCell"
    
    let fileArray: [String] = ["www.polyu.edu.hk/iaee/files/pdf-sample.pdf","upload.wikimedia.org/wikipedia/en/2/24/Lenna.png",]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let file = fileArray[indexPath.row]
        let filePathArray = file.characters.split{$0 == "/"}.map(String.init)
        let fileName = filePathArray.last
        
        cell.textLabel!.text = fileName
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let filePath = fileArray[indexPath.row]
        self.readFile(filePath)
    }
    
    func readFile(filePath: String) {
        RemoteReadFile.sharedInstance.readUrl(filePath, viewController: self)
    }
    

    
    
}
