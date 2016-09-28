//
//  ViewController.swift
//  download image
//
//  Created by Mark on 5/26/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // test if we image is successully download and stored in document directory
        var documentDirectory: String?
        
        //return a collection of paths, but in this case we only have one path
        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            
            documentDirectory = paths[0] as? String
            
            let fullPath = documentDirectory! + "/dota.jpg"
            
            mImage.image = UIImage(named: fullPath)
            
        }
        
        
        //
        //        let url = NSURL(string: "https://s-media-cache-ak0.pinimg.com/736x/dc/30/4a/dc304aa011f9b00053670b5592a7606b.jpg")
        //
        //        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
        //
        //            if error != nil {
        //
        //                print(error)
        //
        //            } else {
        //
        //                var documentDirectory: String?
        //
        //                //return a collection of paths, but in this case we only have one path
        //                var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        //
        //                if paths.count > 0 {
        //
        //                    documentDirectory = paths[0] as? String
        //
        //                    let fullPath = documentDirectory! + "/dota.jpg"
        //
        //                    NSFileManager.defaultManager().createFileAtPath(fullPath, contents: data, attributes: nil)
        //
        //                    dispatch_async(dispatch_get_main_queue(), {
        //
        //                        self.mImage.image = UIImage(named: fullPath)
        //                    })
        //
        //                }
        //
        //            }
        //        }
        //
        //        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

