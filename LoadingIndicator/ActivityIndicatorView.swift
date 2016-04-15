//
//  ActivityIndicatorView.swift
//  LoadingIndicator
//
//  Created by Thong Hao Yi on 02/04/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class ActivityIndicatorView: NSObject {

    static let sharedInstance = ActivityIndicatorView()
    static let loadingView = UIViewController()
    let activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 80, 80))
    
    func showLoadingView(view:UIView){
        activityIndicator.center = view.center;
        activityIndicator.backgroundColor = (UIColor (white: 0.3, alpha: 0.8))   //create a background behind the spinner
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge

        view.addSubview(activityIndicator)
        view.userInteractionEnabled = false
        activityIndicator.startAnimating()
        
    }
    
    
    func showLoadingView(view:UIView, text:String){
        activityIndicator.center = view.center;
        activityIndicator.backgroundColor = (UIColor (white: 0.3, alpha: 0.8))   //create a background behind the spinner
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        
        let loadingTextLabel: UILabel = UILabel()
        loadingTextLabel.text = text
        loadingTextLabel
        
        view.addSubview(activityIndicator)
        view.userInteractionEnabled = false
        activityIndicator.startAnimating()
        
    }
    
    func hideLoadingView(view:UIView){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        view.userInteractionEnabled = true
    }
}

