//
//  TableViewController.swift
//  ScrollView
//
//  Created by Thong Hao Yi on 14/04/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var height:CGFloat = 300;
    var refreshController: UIRefreshControl = UIRefreshControl();
    override func viewDidLoad() {
        super.viewDidLoad()

//        let indexPath:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
//        height = tableView(self.tableView, heightForRowAtIndexPath: indexPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.row)
        {
        case 0:
            return height
        default:
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let firstRowHeight:CGFloat = 300
        
        
        
        if(scrollView.contentOffset.y < firstRowHeight)
            
        {
            self.tableView.beginUpdates()
            height = firstRowHeight - scrollView.contentOffset.y;
            self.tableView.endUpdates()
        }
        
    }

}
