//
//  ViewController.swift
//  AlertViewCOntroller
//
//  Created by Thong Hao Yi on 26/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let comfirmBtn: UIAlertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.Default) { action -> Void in
            //
        }
        let cancelBtn: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "OK"), style: UIAlertActionStyle.Cancel) { action -> Void in
            //
        }
        let uiAlertAction = [comfirmBtn, cancelBtn]
        
        self.warningAndErrorAlert("HI", message: "Test", actionArray: uiAlertAction)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func warningAndErrorAlert(title: String, message: String, actionArray:[UIAlertAction]) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        for action in actionArray{
            alertController.addAction(action)
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

