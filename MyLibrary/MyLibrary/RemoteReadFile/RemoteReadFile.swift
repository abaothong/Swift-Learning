//
//  RemoteReadFile.swift
//  ReadRemoteFile
//
//  Created by Thong Hao Yi on 02/04/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class RemoteReadFile: NSObject,NSURLSessionDownloadDelegate,UIDocumentInteractionControllerDelegate {
    
    static let sharedInstance = RemoteReadFile()
    
    var downloadTask: NSURLSessionDownloadTask!
    var backgroundSession: NSURLSession!
    var documentDirectoryPath: String!
    let fileManager:NSFileManager! = NSFileManager()
    
    var fileName: String!
    var viewController: UIViewController!
    
    // MARK: public method
    func readUrl (urlStr: String, viewController: UIViewController){
        
        var fullFilePathStr = urlStr
        
        if urlStr.hasPrefix("http://") || urlStr.hasPrefix("https://"){
            print("Prefix exists")
        }
        else
        {
            fullFilePathStr = "http://" + urlStr
        }
        self.initRemoteReadFile()
        
        let url = NSURL(string: fullFilePathStr)
        
        self.fileName = url!.lastPathComponent
        self.viewController = viewController
        
        downloadTask = backgroundSession.downloadTaskWithURL(url!)
        downloadTask.resume()
    }
    
    // MARK: private method
    func initRemoteReadFile() {
        let backgroundSessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("backgroundSession")
        backgroundSession = NSURLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        self.documentDirectoryPath = path[0]
        
    }
    func showFileWithPath(path: String){
        let isFileFound:Bool? = NSFileManager.defaultManager().fileExistsAtPath(path)
        if isFileFound == true{
            let viewer = UIDocumentInteractionController(URL: NSURL(fileURLWithPath: path))
            viewer.delegate = self
            viewer.presentPreviewAnimated(true)
        }
    }

    // MARK: NSURLSessionDelegate
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        
        
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
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?){
        downloadTask = nil
        if (error != nil) {
            print(error?.description)
        }else{
            print("The task finished transferring data successfully")
        }
    }

    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {

        if !session.configuration.identifier!.isEmpty {

        }
    }
    
    // MARK: UIDocumentInteractionControllerDelegate
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController{
        return self.viewController
    }
    
    
}