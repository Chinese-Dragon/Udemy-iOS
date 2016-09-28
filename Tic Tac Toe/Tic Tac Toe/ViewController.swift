//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Mark on 5/22/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var activePlayer = 1  // 1 is circle 2 is cross
    var gameState = [0,0,0,0,0,0,0,0,0]
    var winSituations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var alreadyWon = false
    var counter = 1
    var timer = NSTimer()
    var noTie = true
    
    @IBOutlet var message: UILabel!
    @IBOutlet var mImage: UIImageView!
    @IBOutlet var mButton: UIButton!
    
    
    @IBAction func retryButton(sender: AnyObject) {
        gameState = [0,0,0,0,0,0,0,0,0]
        alreadyWon = false
        activePlayer = 1
        
        message.hidden = true
        mImage.hidden = true
        mButton.hidden = true
        
        message.center = CGPointMake(message.center.x - 500, message.center.y)
        mImage.center = CGPointMake(mImage.center.x - 500, mImage.center.y)
        mButton.center = CGPointMake(mButton.center.x - 500, mButton.center.y)
        
        var clearButton : UIButton
        
        var i = 0
        
        while i < 9 {
            
            clearButton = view.viewWithTag(i) as! UIButton
            clearButton.setImage(nil, forState: .Normal)
            
            i = i + 1
        }
    }
    
    func doAnimation(){
        
        if (counter == 6) {
            counter = 1
        } else {
            counter = counter + 1
        }
        
        mImage.image = UIImage(named:"con\(counter).png")
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        if !alreadyWon && noTie {
            if gameState[sender.tag] == 0 {
                
                let originalNought = UIImage(named: "nought.png")
                let originalCross = UIImage(named: "cross.png")
                
                gameState[sender.tag] = activePlayer
                
                if activePlayer == 1 {
                    sender.setImage(originalNought, forState: .Normal)
                    activePlayer = 2
                } else {
                    sender.setImage(originalCross, forState: .Normal)
                    activePlayer = 1
                }
                
                for situation in winSituations {
                    
                    if gameState[situation[0]] != 0 && gameState[situation[0]] == gameState[situation[1]] && gameState[situation[1]] == gameState[situation[2]]{
                        
                        alreadyWon = true
                        
                        if gameState[situation[0]] == 1 {
                            message.text = "Noughts have own !"
                        } else {
                            message.text = "Crosses have own !"
                        }
                        
                        endGame()
                        
                    }
                }
                
                
                noTie = false
                for check in gameState {
                    
                    if(check == 0) {
                        noTie = true
                    }
                }
                
                if(!noTie) {
                    message.text = "That's a Tie !"
                    endGame()
                }
                
            }
        }
    }
    

    func endGame() {
        
        message.hidden = false
        mImage.hidden = false
        mButton.hidden = false
        
        UIView.animateWithDuration(1, animations: {
            self.message.center = CGPointMake(self.message.center.x + 500, self.message.center.y)
            self.mImage.center = CGPointMake(self.mImage.center.x + 500, self.mImage.center.y)
            self.mButton.center = CGPointMake(self.mButton.center.x + 500, self.mButton.center.y)
        })
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.doAnimation), userInfo: nil, repeats: true)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        message.hidden = true
        mImage.hidden = true
        mButton.hidden = true
        
        message.center = CGPointMake(message.center.x - 500, message.center.y)
        mImage.center = CGPointMake(mImage.center.x - 500, mImage.center.y)
        mButton.center = CGPointMake(mButton.center.x - 500, mButton.center.y)
        
        
    }
 
    
}

