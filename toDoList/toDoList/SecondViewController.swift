//
//  SecondViewController.swift
//  toDoList
//
//  Created by Mark on 5/20/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var input: UITextField!
    
    @IBAction func add(sender: AnyObject) {
        data.append(input.text!)
        
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "myData")
        
        input.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.input.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        input.resignFirstResponder()
        return true
    }


}

