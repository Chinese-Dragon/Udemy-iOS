//
//  ViewController.swift
//  storage
//
//  Created by Mark on 5/20/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //NSUserDefaults.standardUserDefaults().setObject("Mark", forKey: "name")
        
        let myName = NSUserDefaults.standardUserDefaults().objectForKey("name") as! String
        
        print(myName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

