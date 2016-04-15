//
//  UserListTableViewController.swift
//  MyNameCard
//
//  Created by Thong Hao Yi on 26/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit
import CoreData

class UserListTableViewController: BaseTableViewController ,UISearchBarDelegate{
    let searchBar: UISearchBar = UISearchBar()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let cellIdentifier = "UserListTableViewCell"
    var userArray = [User]()
    var filterUserArray = [User]()
    var sectionIndex = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = true
        
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Search"
        self.searchBar.sizeToFit()
        self.navigationItem.titleView = self.searchBar
        
        let backgroundView: UIImageView = UIImageView(image: UIImage(named: "bg_grass.jpg"))
        backgroundView.frame = self.tableView.frame
        backgroundView.contentMode = .ScaleAspectFill
        self.tableView.backgroundView = backgroundView
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchData()
    }
    
    // MARK: TableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterUserArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UserListTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UserListTableViewCell
        
        let user = filterUserArray[indexPath.row]
        let fullName = "\(user.first_name!) \(user.last_name!)"
        
        cell.fullNameLabel.text = fullName
        return cell
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let user = filterUserArray[indexPath.row]
            self.deleteRow(user)
        }
    }
    
    // MARK: Fetch Core Data
    func fetchData() {
        let request: NSFetchRequest = NSFetchRequest(entityName: CoreDataConfig.userEntity)
        let sortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "create_date", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            userArray = try managedObjectContext.executeFetchRequest(request) as! [User]
            filterUserArray = userArray
            self.tableView.reloadData()
            // success ...
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    func fetchData(keyWord: String) {
        if (keyWord.characters.count > 0) {
            filterUserArray = userArray.filter() {
                let first_name = ($0 as User).first_name!.rangeOfString(keyWord) != nil
                let last_name = ($0 as User).last_name!.rangeOfString(keyWord) != nil
                return first_name || last_name
            }
        } else {
            filterUserArray = userArray
        }
        
        self.tableView.reloadData()
    }
    func deleteRow(user: User) {
        managedObjectContext.deleteObject(user)
        do {
            try self.managedObjectContext.save()
            
            userArray.removeAtIndex(userArray.indexOf(user)!)
            
            if (self.searchBar.text?.characters.count > 0) {
                self.fetchData(self.searchBar.text!)
            } else {
                self.fetchData()
            }
            
        } catch {
            fatalError("Failure to delete context: \(error)")
        }
        
    }
    
    // MARK:SearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.fetchData(searchText)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        self.fetchData()
        self.searchBar.resignFirstResponder()
    }
    // MARK: Private Function
}

