//
//  ViewController.swift
//  LoadingIndicator
//
//  Created by Thong Hao Yi on 02/04/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let activityIndicatorView = ActivityIndicatorView.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startLoading(){
        activityIndicatorView.showLoadingView(self.navigationController!.view)
        
        let trigerTImer = (Int64(NSEC_PER_SEC) * 2)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, trigerTImer), dispatch_get_main_queue(), { () -> Void in
            self.stopLoading()
        })
        
    }

    @IBAction func stopLoading(){
        activityIndicatorView.hideLoadingView(self.navigationController!.view)
    }
}

