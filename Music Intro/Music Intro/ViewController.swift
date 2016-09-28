//
//  ViewController.swift
//  Music Intro
//
//  Created by Mark on 5/24/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer = AVAudioPlayer()
    var timer = NSTimer()
    var counter = 0
    @IBOutlet var volume: UISlider!
    @IBOutlet var progress: UISlider!
    
    @IBAction func adjustProgress(sender: AnyObject) {
        
        player.currentTime = Double(progress.value)
        
    }
    
    @IBAction func adjustVolume(sender: AnyObject) {
        
        player.volume = volume.value
        
    }
    
    @IBAction func stop(sender: AnyObject) {
        player.stop()
        player.currentTime = NSTimeInterval(0.0)
        progress.value = Float(player.currentTime)
        timer.invalidate()
    }
    @IBAction func pause(sender: AnyObject) {
        
        player.pause()
        timer.invalidate()
        
    }
    @IBAction func play(sender: AnyObject) {
        
        player.play()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateProgress), userInfo: nil, repeats: true)
        
    }
    
    func updateProgress(){
        
        counter = counter + 1
        
        progress.value = Float(player.currentTime)
        if !player.playing {
            timer.invalidate()
        }
        
        
        print(counter)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let audioPath = NSBundle.mainBundle().pathForResource("Fade", ofType: "mp3")
        
        do {
            
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:audioPath!))
            
        } catch {
            //PROCESS
        }
        
        progress.maximumValue = Float(player.duration)
        
        progress.value = Float(player.currentTime)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

