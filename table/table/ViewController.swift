//
//  ViewController.swift
//  table
//
//  Created by Mark on 5/19/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    var data = ["China","U.S","UK","Japan","Korea"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
        
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

