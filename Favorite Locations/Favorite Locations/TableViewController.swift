//
//  TableViewController.swift
//  Favorite Locations
//
//  Created by Mark on 5/24/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit

var activePlace = -1
var data = [Dictionary<String,String>()]

class TableViewController: UITableViewController {
    
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NSUserDefaults.standardUserDefaults().objectForKey("myData") != nil{
            data = NSUserDefaults.standardUserDefaults().objectForKey("myData") as! [Dictionary<String,String>]
        }
        
        print(data.count)
        if data.count == 1{
            
            print(data[0].count)
            if(data[0].count == 0 ){
                data.removeAtIndex(0)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = data[indexPath.row]["name"]

        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        
        table.reloadData()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        activePlace = indexPath.row
        
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "newPlace" {
            activePlace = -1
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            data.removeAtIndex(indexPath.row)
            
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "myData")
            
            table.reloadData()
        }
    
    }

    

}
