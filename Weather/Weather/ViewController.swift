 //
//  ViewController.swift
//  Weather
//
//  Created by Mark on 5/21/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var input: UITextField! {
        didSet {
            input.delegate = self
        }
    }
    
    @IBOutlet var weatherInfo: UILabel!
    
    @IBAction func search(sender: AnyObject?) {
        
        let trimmedInput = input.text!.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        
        if input.text != "" {
            
            let attemptedUrl = NSURL(string:"http://www.weather-forecast.com/locations/"+trimmedInput.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
            
            if let url = attemptedUrl {
                
                let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
                    
                    let urlReponse = String(response)
                    
                    if urlReponse.containsString("404") == false {
                        
                        if let urlContent = data  {
                            
                            let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                            
                            let contentArray = webContent?.componentsSeparatedByString("<span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                            
                            if contentArray!.count > 1{
                                
                                let weatherArray = contentArray![1].componentsSeparatedByString("</span></span></span></p><div class=\"forecast-cont\"><div class=\"units-cont\">")
                                
                                if weatherArray.count > 1 {
                                    let weatherData = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        
                                        self.weatherInfo.text = weatherData
                                        self.input.text = ""
                                        self.weatherInfo.textColor = UIColor.greenColor()
                                        
                                    })
                                } else {
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        self.weatherInfo.text = "Couldn't Find Weather For "+self.input.text!+" Please Try Again"
                                        self.input.text = ""
                                        self.weatherInfo.textColor = UIColor.redColor()
                                    })
                                }
                            }else {
                                
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.weatherInfo.text = "Couldn't Find Weather For "+self.input.text!+" Please Try Again"
                                    self.input.text = ""
                                    self.weatherInfo.textColor = UIColor.redColor()
                                })
                                
                            }
                            
                        } else {
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                self.weatherInfo.text = "Couldn't Find Weather For "+self.input.text!+" Please Try Again"
                                self.input.text = ""
                                self.weatherInfo.textColor = UIColor.redColor()
                            })
                        }
                    }else {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.weatherInfo.text = "Couldn't Find Weather For "+self.input.text!+" Please Try Again"
                            self.input.text = ""
                            self.weatherInfo.textColor = UIColor.redColor()
                        })
                    }
                    
                }
                
                task.resume()
                
            } else {
                
                weatherInfo.text = "Couldn't Find Weather For "+input.text!+" Please Try Again"
                input.text = ""
                weatherInfo.textColor = UIColor.redColor()
                
            }
        } else {
            weatherInfo.text = "City name cannot be empty"
            weatherInfo.textColor = UIColor.redColor()
        }
        
    }
 
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        input.resignFirstResponder()
        
        self.search(nil)
        return true
    }
    
}

