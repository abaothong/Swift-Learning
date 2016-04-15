//
//  MyTextField.swift
//  MyNameCard
//
//  Created by Thong Hao Yi on 27/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class FormTextField: UITextField {
    
    override func drawPlaceholderInRect(rect: CGRect) {
        
        let placeholderRect = CGRectMake(rect.origin.x, (rect.size.height - self.font!.pointSize)/2 - 2 , rect.size.width, self.font!.pointSize + 4);
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Right
        
        let font = self.font ?? self.typingAttributes![NSFontAttributeName] as? UIFont ?? UIFont.systemFontOfSize(UIFont.systemFontSize())
        

        
        let textFontAttributes : [String : AnyObject] = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: Color.defaultPlaceholderColor,
            NSParagraphStyleAttributeName: paragraphStyle
        ]
        // draw in rect.
        self.placeholder?.drawInRect(placeholderRect, withAttributes: textFontAttributes)
    }
    
    override func drawTextInRect(rect: CGRect) {
        let placeholderRect = CGRectMake(rect.origin.x, (rect.size.height - self.font!.pointSize)/2 - 2, rect.size.width, self.font!.pointSize + 4);
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Right
        
        let font = self.font ?? self.typingAttributes![NSFontAttributeName] as? UIFont ?? UIFont.systemFontOfSize(UIFont.systemFontSize())
        
        
        
        let textFontAttributes : [String : AnyObject] = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSParagraphStyleAttributeName: paragraphStyle
        ]
        // draw in rect.
        self.text?.drawInRect(placeholderRect, withAttributes: textFontAttributes)
    }

}
