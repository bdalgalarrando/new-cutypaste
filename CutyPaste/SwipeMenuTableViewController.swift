//
//  SwipeMenuTableViewController.swift
//  CutyPaste
//
//  Created by Catalina Balmaceda on 23-08-15.
//  Copyright (c) 2015 Catalina Balmaceda. All rights reserved.
//

import UIKit

protocol sidebarTableViewControllerDelegate {
    func sidebarDidSelectRow(indexPath: NSIndexPath)
}

class SideBarTableViewController: UITableViewController {

    var delegate:sidebarTableViewControllerDelegate?
    var tableData:Array<String> = []
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return tableData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell

        if cell == nil {
        
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.blackColor()
            
            let selectedView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height:cell!.frame.size.height))
            selectedView.backgroundColor = UIColor.clearColor()
            
            cell!.selectedBackgroundView = selectedView
        }
        
        cell!.textLabel!.text = tableData[indexPath.row]

        // Configure the cell...

        return cell!
    }
    
    //height of the swipe bar
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 25.0
    }

    //display all the items on the sidebar
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.sidebarDidSelectRow(indexPath)
    }

}
