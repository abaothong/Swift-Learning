//
//  ViewController.swift
//  HelloWorld
//
//  Created by Thong Hao Yi on 19/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.label?.text = "hello"
        myName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func myName()
    {
        var response = Dictionary<String, Any>()
        response["user"] = ["Login": "Power Ranger", "Password": "Mighty Morfin'"]
        response["status"] = 200
        
        for(key,value)in response
        {
            let objectClass: AnyClass = object_getClass(value) as AnyClass
            let objectClassName =  NSStringFromClass(objectClass)
            print("Class = \(objectClassName)")
            print("Class = \(objectClassName)\n \(key): \(value)")
        }
    }
}

