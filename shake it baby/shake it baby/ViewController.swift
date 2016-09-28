//
//  ViewController.swift
//  shake it baby
//
//  Created by Mark on 5/25/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    var sounds = ["1","2","3","4","5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.MotionShake {
            
            var randomNum = Int(arc4random_uniform(UInt32(sounds.count)))
            
            var fileLocation = NSBundle.mainBundle().pathForResource(sounds[randomNum], ofType: "mp3")
            
            do {
               try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: fileLocation!))
                player.play()
            } catch {
                
            }
        }
    }

}

