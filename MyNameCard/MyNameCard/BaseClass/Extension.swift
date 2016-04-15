//
//  Extension.swift
//  MyNameCard
//
//  Created by Thong Hao Yi on 29/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

extension UILabel {
    
    var substituteFontName: String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
    
    var textFieldColor: UIColor
    {
        get { return self.textColor }
        set { self.textColor = newValue }

    }
    
    override public func awakeFromNib() {
        self.textColor = UIColor.blueColor()
        self.font = UIFont(name: "Bradley Hand", size: self.font.pointSize)
    }
}


