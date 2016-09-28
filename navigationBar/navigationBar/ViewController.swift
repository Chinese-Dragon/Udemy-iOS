//
//  ViewController.swift
//  navigationBar
//
//  Created by Mark on 5/19/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = NSTimer()
    var minuate = 0
    var second = 0
    
    @IBOutlet var time: UILabel!
    
    @IBAction func start(sender: AnyObject) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(ViewController.increaseTime), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func pause(sender: AnyObject) {
        timer.invalidate()
    }
    
    @IBAction func clear(sender: AnyObject) {
        timer.invalidate()
        time.text = "0:00"
        minuate = 0
        second = 0
    }
    
    func increaseTime() {
        second = second + 1
        
        if second == 60 {
            minuate = minuate + 1
            second = 0
            time.text = "\(minuate)"+":"+"00"
        } else if second < 10 {
            time.text = "\(minuate)"+":0"+"\(second)"
        } else if second > 10 {
            time.text = "\(minuate)"+":"+"\(second)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

