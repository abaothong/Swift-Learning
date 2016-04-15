//
//  RemoteReadFile.swift
//  ReadRemoteFile
//
//  Created by Thong Hao Yi on 02/04/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class RemoteReadFile: NSObject,NSURLSessionDelegate,UIDocumentInteractionControllerDelegate {
    
    var downloadTask: NSURLSessionDownloadTask!
    var backgroundSession: NSURLSession!
    var documentDirectoryPath: String!
    let fileManager:NSFileManager! = NSFileManager()
    
    var fileName: String!
    var viewController: UIViewController!
    
    func readUrl(urlStr: String, viewController: UIViewController){
        
        self.initRemoteReadFile()
        
        let url = NSURL(string: urlStr)
        
        self.fileName = url!.lastPathComponent
        self.viewController = viewController
        
        downloadTask = backgroundSession.downloadTaskWithURL(url!)
        downloadTask.resume()
    }
    
    func initRemoteReadFile() {
        let backgroundSessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("backgroundSession")
        backgroundSession = NSURLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        self.documentDirectoryPath = path[0]
        
    }
    
    func URLSession(session: NSURLSession,
        downloadTask: NSURLSessionDownloadTask,
        didFinishDownloadingToURL location: NSURL){
            
            
            let destinationURLForFile = NSURL(fileURLWithPath: self.documentDirectoryPath.stringByAppendingString(self.fileName!))
            
            if self.fileManager.fileExistsAtPath(destinationURLForFile.path!){
                showFileWithPath(destinationURLForFile.path!)
            }
            else{
                do {
                    try fileManager.moveItemAtURL(location, toURL: destinationURLForFile)
                    // show file
                    showFileWithPath(destinationURLForFile.path!)
                }catch{
                    print("An error occurred while moving file to destination url")
                }
            }
    }
    
    func showFileWithPath(path: String){
        let isFileFound:Bool? = NSFileManager.defaultManager().fileExistsAtPath(path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(URL: NSURL(fileURLWithPath: path))
            viewer.delegate = self
            viewer.presentPreviewAnimated(true)
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController{
        return self.viewController
    }
    
    
}