//
//  BaseTableViewController.swift
//  MyNameCard
//
//  Created by Thong Hao Yi on 20/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewNameCard")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNewNameCard(){
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addNewnameCardTableViewContoller = mainStoryBoard.instantiateViewControllerWithIdentifier("AddNewNameCardTableViewController")
        
        // sample for modelpresentview
//        addNewnameCardTableViewContoller.modalPresentationStyle = .OverCurrentContext
//        presentViewController(addNewnameCardTableViewContoller, animated: true, completion: nil)
        
        //self.navigationController!.pushViewController(addNewnameCardTableViewContoller, animated: false)

        
        let transition = CATransition()
        transition.duration = 0.5;
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        self.navigationController!.view.layer.addAnimation(transition, forKey: nil)
        self.navigationController!.pushViewController(addNewnameCardTableViewContoller, animated: false)
        
    }
    
    // MARK: Pop Out View
    func warningAndErrorAlert(title: String, message: String, alertActions:[UIAlertAction]) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        for action in alertActions{
            alertController.addAction(action)
        }
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func messageAlert(title: String, message: String, alertActions:[UIAlertAction]) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        for action in alertActions{
            alertController.addAction(action)
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
