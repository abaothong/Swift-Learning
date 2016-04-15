//
//  FontFamilyTableViewController.swift
//  FontFamily
//
//  Created by Thong Hao Yi on 30/03/2016.
//  Copyright © 2016 Thong Hao Yi. All rights reserved.
//

import UIKit

class FontFamilyTableViewController: UITableViewController {

    let cellIdentifier = "UITableViewCell"
    let fontFamilyNames:[String] = UIFont.familyNames()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontFamilyNames.count;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let fontName = fontFamilyNames[indexPath.row]

        
        cell.textLabel!.text = fontName
        cell.textLabel!.font = UIFont(name: fontName, size: (cell.textLabel!.font.pointSize))
        NSLog("%@", fontName)
        return cell
    }
}
