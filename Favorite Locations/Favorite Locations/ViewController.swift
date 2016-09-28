//
//  ViewController.swift
//  Favorite Locations
//
//  Created by Mark on 5/24/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit
import MapKit



class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(activePlace)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace == -1 {
            //means user did not select on any view (they wanna add places)
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        } else {
            let location = CLLocationCoordinate2DMake(Double(data[activePlace]["lat"]!)!, Double(data[activePlace]["long"]!)!)
            zoomInLocation(location)
            addAnnotation(location,title: data[activePlace]["name"]!)
        }
        
        
        //long press
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.action(_:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began){
            
            let toughPoint = gestureRecognizer.locationInView(self.map)
            let newCoordinate : CLLocationCoordinate2D = map.convertPoint(toughPoint, toCoordinateFromView: self.map)
            let newLocation: CLLocation  = CLLocation.init(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(newLocation) { (placemarks, error) in
                
                var title = ""
                
                if(error != nil) {
                    print(error)
                } else {
                    
                    if let pm: CLPlacemark = placemarks?[0] {
                        
                        var subThoughfare = ""
                        var thoroughfare = ""
                        
                        if pm.subThoroughfare != nil {
                            subThoughfare = pm.subThoroughfare!
                        }
                        
                        if pm.thoroughfare != nil {
                            thoroughfare = pm.thoroughfare!
                        }
                        
                        if pm.thoroughfare == nil && pm.subThoroughfare == nil {
                            title = "\(pm.name!)"
                        } else {
                            title = "\(subThoughfare) \(thoroughfare)"
                        }
                        
                    }
                }
                
                if title == "" {
                    title = "Added\(NSDate())"
                }
                
                data.append(["name":title,"lat":"\(newCoordinate.latitude)","long":"\(newCoordinate.longitude)"])
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: "myData")
                
                //set up annotation to show on map
                self.addAnnotation(newCoordinate, title: title)
            }
            
        }
        
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        
        //zoom in for user current location
        zoomInLocation(userLocation.coordinate)
        
        map.showsUserLocation = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func zoomInLocation(locationCoordinate:CLLocationCoordinate2D) {
        let latDelta: CLLocationDegrees = 0.01
        let longDelta: CLLocationDegrees = 0.01
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, span)
        map.setRegion(region, animated: true)
    }
    
    func addAnnotation(locationCoordinate:CLLocationCoordinate2D,title:String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = title
        map.addAnnotation(annotation)
    }
    
    
}

