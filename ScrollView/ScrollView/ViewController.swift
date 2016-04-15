//
//  ViewController.swift
//  ScrollView
//
//  Created by Thong Hao Yi on 13/04/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var topViewHeight: NSLayoutConstraint!
    @IBOutlet var scrollViewContant: NSLayoutConstraint!
    
    @IBOutlet var imageView: UIImageView!
    var defaultFrame:CGRect = CGRect();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.scrollView.delegate = self;
        
        self.topView.setNeedsLayout()
        self.topView.layoutIfNeeded()
        defaultFrame = self.topView.frame
        
        self.bottomView.setNeedsLayout()
        self.bottomView.layoutIfNeeded()
        let height = bottomView.frame.size.height + bottomView.frame.origin.y + 8.0 - 100
        scrollViewContant.constant = height;
        
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.sd_setImageWithURL(NSURL(string: "http://thumb101.shutterstock.com/display_pic_with_logo/2059001/200208233/stock-photo-cup-of-black-coffee-and-roasted-coffe-beans-close-up-with-title-coffee-break-200208233.jpg"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if(scrollView.contentOffset.y < defaultFrame.height && scrollView.contentOffset.y > (defaultFrame.height * -0.5)){
            let height = defaultFrame.height - scrollView.contentOffset.y;
            NSLog("%f", height)
            topViewHeight.constant = height
        }
    }
}

