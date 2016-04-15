//
//  DatePickerTextField.swift
//  MyNameCard
//
//  Created by Thong Hao Yi on 23/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class DatePickerTextField: FormTextField {
    
    let datePickerView :UIDatePicker = UIDatePicker()

    
    enum ToolbarButtonSetting : Int{
        case NoToolbar
        case CancelButtonAndDoneButton
        case CancelButton
        case DoneButton
    }
    
    //set NSDateFormatter string
    var dateFormat: String = "dd MMM yyyy"
    
    //set inputAccessoryView
    var toolbarSetting: ToolbarButtonSetting = .NoToolbar
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.datePickerView.datePickerMode = UIDatePickerMode.Date
        self.datePickerView.addTarget(self, action: "datePickerHandler:", forControlEvents: UIControlEvents.ValueChanged)

    }
    
    func setAccessoryView(toolbarSetting:ToolbarButtonSetting)
    {
        let toolBar :UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.sizeToFit()
        
        let CancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "hidePressed:")
        
        let leftEmptyButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "donePressed:")
        
        self.inputView = self.datePickerView
        switch toolbarSetting {
        case .NoToolbar:
            break;
        case .CancelButtonAndDoneButton:
            toolBar.setItems([CancelButton, leftEmptyButton, doneButton], animated: true)
            self.inputAccessoryView = toolBar
            break;
        case .CancelButton:
            toolBar.setItems([CancelButton, leftEmptyButton], animated: true)
            self.inputAccessoryView = toolBar
            break;
        case .DoneButton:
            toolBar.setItems([leftEmptyButton, doneButton], animated: true)
            self.inputAccessoryView = toolBar
            break;
        }
    }
    
    func datePickerHandler(datePicker: UIDatePicker){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = self.dateFormat
        self.text = dateFormatter.stringFromDate(datePicker.date)
    }
    
    func hidePressed(sender: UIBarButtonItem) {
        self.resignFirstResponder()
    }
    
    func donePressed(sender: UIBarButtonItem) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = self.dateFormat
        self.text = dateFormatter.stringFromDate(self.datePickerView.date)
    }
    
    
}
