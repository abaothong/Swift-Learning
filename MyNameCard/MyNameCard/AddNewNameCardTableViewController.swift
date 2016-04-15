//
//  AddNewNameCardTableViewController.swift
//  MyNameCard
//
//  Created by Thong Hao Yi on 20/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//
import UIKit
import CoreData

class AddNewNameCardTableViewController: BaseTableViewController, UITextFieldDelegate {
    // MARK: Parameter
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet var dateOfBirthTextField: DatePickerTextField! = DatePickerTextField()
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var mobileLabel: UILabel!
    
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var officePhoneTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var postCodeTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    let personalDetailHeaderButton: UIButton = UIButton()
    var personalSectionRowHeight:CGFloat = 50.0
    
    let companyDetailHeaderButton: UIButton = UIButton()
    var companySectionRowHeight:CGFloat = 50.0
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // MARK:ViewControllerFunction
    override func viewDidLoad() {
        
        navigationController?.hidesBarsOnSwipe = false;
        
        self.firstNameTextField?.delegate = self
        self.lastNameTextField?.delegate = self
        self.mobileTextField?.delegate = self
        self.dateOfBirthTextField.setAccessoryView(.CancelButtonAndDoneButton)
        
        self.setupNavigationBar()
    }
    func setupNavigationBar()
    {
        let saveButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveBtnClick")
        self.navigationItem.rightBarButtonItem = saveButton
        
        let cancelButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelBtnClick")
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func saveBtnClick(){
        let isFormValid = self.checkFormValue()
        if (isFormValid == false) {
            
            let comfirmBtn: UIAlertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.Cancel) { action -> Void in
                //
            }
            let alertActionArray = [comfirmBtn]
            let title = NSLocalizedString("Sorry", comment: "Sorry")
            let message = NSLocalizedString("Some_data_is_empty", comment: "Some data is empty")
            
            super.warningAndErrorAlert(title, message: message, alertActions:alertActionArray)
            
            return
        } else {
            self.saveUser()
            
        }
    }
    
    func cancelBtnClick(){
        let isFormEmpty = self.checkFormEmpty()
        if (isFormEmpty == true) {
            self.exitView()
        } else {
            let comfirmBtn: UIAlertAction = UIAlertAction(title: NSLocalizedString("Exit", comment: "Exit"), style: UIAlertActionStyle.Default) { action -> Void in
                self.exitView()
            }
            let cancelBtn: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: UIAlertActionStyle.Cancel, handler: nil)
            
            let alertActionArray = [comfirmBtn,cancelBtn]
            let title = NSLocalizedString("Warning", comment: "Warning")
            let message = NSLocalizedString("Form_no_save_warning", comment: "Form no save")
            
            super.warningAndErrorAlert(title, message: message, alertActions:alertActionArray)
        }
    }
    
    func exitView() {
        let transition = CATransition()
        transition.duration = 0.5;
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        self.navigationController!.view.layer.addAnimation(transition, forKey: nil)
        self.navigationController!.popViewControllerAnimated(false)
    }
    
    func headerViewPersonalDetailButton() -> UIView {
        
        personalDetailHeaderButton.sizeToFit()
        
        personalDetailHeaderButton.setTitle("Personal Detail", forState: .Normal)
        personalDetailHeaderButton.setTitleColor(UIColor.brownColor(), forState: .Normal)
        personalDetailHeaderButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 2.0, right: 0)
        personalDetailHeaderButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        personalDetailHeaderButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        
        if(personalSectionRowHeight < 1.0) {
            personalDetailHeaderButton.setImage(UIImage(named: "expand"), forState: .Normal)
        } else {
            personalDetailHeaderButton.setImage(UIImage(named: "collapse"), forState: .Normal)
        }
        
        personalDetailHeaderButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 4.0, right: 0.0)
        personalDetailHeaderButton.addTarget(self, action: "headerViewPersonalDetailButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return personalDetailHeaderButton
    }
    func headerViewPersonalDetailButtonClick() {
        
        if(personalSectionRowHeight < 1.0) {
            personalSectionRowHeight = 50.0;
        } else {
            personalSectionRowHeight = 0.0;
        }
        
        tableView.reloadData()

    }
    func headerViewCompanyDetailButton() -> UIView {
        
        companyDetailHeaderButton.sizeToFit()
        
        companyDetailHeaderButton.setTitle("Company Detail", forState: .Normal)
        companyDetailHeaderButton.setTitleColor(UIColor.brownColor(), forState: .Normal)
        companyDetailHeaderButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 2.0, right: 0)
        companyDetailHeaderButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        companyDetailHeaderButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        
        if(companySectionRowHeight < 1.0) {
            companyDetailHeaderButton.setImage(UIImage(named: "expand"), forState: .Normal)
        } else {
            companyDetailHeaderButton.setImage(UIImage(named: "collapse"), forState: .Normal)
        }
        
        companyDetailHeaderButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 4.0, right: 0.0)
        companyDetailHeaderButton.addTarget(self, action: "headerViewCompanyDetailButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return companyDetailHeaderButton
    }
    func headerViewCompanyDetailButtonClick() {
        
        if(companySectionRowHeight < 1.0) {
            companySectionRowHeight = 50.0;
        } else {
            companySectionRowHeight = 0.0;
        }

        self.tableView.reloadData()
    }
    // MARK:tableviewDelegate
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch (section) {
        case 0:
            return self.headerViewPersonalDetailButton()
        case 1:
            return self.headerViewCompanyDetailButton()
        case 2:
            return super.tableView(tableView, viewForHeaderInSection: section)
        default:
            return super.tableView(tableView, viewForHeaderInSection: section)
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = indexPath.section
        switch (section) {
        case 0:
            return personalSectionRowHeight
        case 1:
            return companySectionRowHeight
        case 2:
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        default:
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    
    
    // MARK:UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == self.firstNameTextField)
        {
            self.lastNameTextField?.becomeFirstResponder()
        }
        else if(textField == self.lastNameTextField)
        {
            self.dateOfBirthTextField?.becomeFirstResponder()
        }
        return true
    }

    // MARK:CoreData
    func saveUser() {
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName(CoreDataConfig.userEntity, inManagedObjectContext: self.managedObjectContext) as! User
        
        newUser.first_name = self.firstNameTextField.text
        newUser.last_name = self.lastNameTextField.text
        newUser.date_of_birth = self.getDateFromString(self.dateOfBirthTextField.text!)
        newUser.mobile_no = self.mobileTextField.text
        
        do {
            try self.managedObjectContext.save()
            

            let title = NSLocalizedString("Success", comment: "Success")
            let message = NSLocalizedString("Save_user_success", comment: "Save user success")
            
            let comfirmBtn: UIAlertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.Cancel) { action -> Void in
                self.exitView()
            }

            let alertActionArray = [comfirmBtn]
            
            super.messageAlert(title, message: message, alertActions: alertActionArray)
        }catch{
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    // MARK:PRIVATE FUNCTION
    func checkFormValue() -> Bool{
        var formValid: Bool = true
        
        let isFormEmpty = self.checkFormEmpty()
        
        if (isFormEmpty == true)
        {
            formValid = false
        }
        
        let firstName: String = self.firstNameTextField.text!
        let lastName: String = self.lastNameTextField.text!
        let mobilePhoneNo: String = self.mobileTextField.text!
        let dob: String = self.dateOfBirthTextField.text!
        
        if (firstName.characters.count < 1 || lastName.characters.count < 1 || mobilePhoneNo.characters.count < 1 || dob.characters.count < 1){
            formValid = false
        }
        
        
        let companyName: String = self.companyTextField.text!
        let position: String = self.positionTextField.text!
        let officePhoneNo: String = self.officePhoneTextField.text!
 
        if (companyName.characters.count < 1 || position.characters.count < 1 || officePhoneNo.characters.count < 1) {
            formValid = false
        }
        
        return formValid
    }
    
    func checkFormEmpty() -> Bool{
        var formEmpty: Bool = false
        
        let firstName: String = self.firstNameTextField.text!
        let lastName: String = self.lastNameTextField.text!
        let mobilePhoneNo: String = self.mobileTextField.text!
        let dob: String = self.dateOfBirthTextField.text!
        
        if (firstName.characters.count < 1 && lastName.characters.count < 1 && mobilePhoneNo.characters.count < 1 && dob.characters.count < 1){
            formEmpty = true
        }
        
        let companyName: String = self.companyTextField.text!
        let position: String = self.positionTextField.text!
        let officePhoneNo: String = self.officePhoneTextField.text!
        
        if (companyName.characters.count < 1 || position.characters.count < 1 || officePhoneNo.characters.count < 1) {
            formEmpty = true
        }
        
        return formEmpty
    }
    
    func getDateFromString(dateStr: String) -> NSDate{
        var date = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        date = dateFormatter.dateFromString(dateStr)!
        
        return date
    }
}
