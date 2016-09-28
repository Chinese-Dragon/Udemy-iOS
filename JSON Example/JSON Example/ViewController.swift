//
//  ViewController.swift
//  JSON Example
//
//  Created by Mark on 5/26/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "https://freegeoip.net/json/")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            if let urlContent = data {
            
                do {
                
                   let jsonResult =  try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    print(jsonResult)
                } catch {
                
                    print("JSON serialization failed")
                }
            }
            
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

