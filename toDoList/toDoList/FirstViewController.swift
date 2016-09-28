//
//  FirstViewController.swift
//  toDoList
//
//  Created by Mark on 5/20/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit

var data = [String]()

class FirstViewController: UIViewController,UITableViewDelegate {

    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if NSUserDefaults.standardUserDefaults().objectForKey("myData") != nil{
            data = NSUserDefaults.standardUserDefaults().objectForKey("myData") as! [String]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return data.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
        
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        table.reloadData()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            data.removeAtIndex(indexPath.row)
            
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "myData")
            
            table.reloadData()
        }
        
    
    }

    
    

}

