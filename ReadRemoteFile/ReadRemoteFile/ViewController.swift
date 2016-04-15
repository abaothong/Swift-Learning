//
//  ViewController.swift
//  ReadRemoteFile
//
//  Created by Thong Hao Yi on 02/04/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let remoteReadFile: RemoteReadFile = RemoteReadFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteReadFile.readUrl("http://www.polyu.edu.hk/iaee/files/pdf-sample.pdf",viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

