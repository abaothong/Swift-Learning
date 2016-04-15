//
//  StartViewController.swift
//  LoadingIndicator
//
//  Created by Thong Hao Yi on 02/04/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let trigerTImer = (Int64(NSEC_PER_SEC) * 2)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, trigerTImer), dispatch_get_main_queue(), { () -> Void in
            self.pushView()
            })
    }
    
    func pushView(){
        let viewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController")
        self.navigationController?.pushViewController(viewcontroller!, animated: true)
    }

}
