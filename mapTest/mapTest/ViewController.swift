//
//  ViewController.swift
//  mapTest
//
//  Created by Mark on 5/23/16.
//  Copyright © 2016 Mark. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate  {

    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    @IBOutlet var curAltitude: UILabel!
    @IBOutlet var curSpeed: UILabel!
    @IBOutlet var curCourse: UILabel!
    @IBOutlet var curLongtitude: UILabel!
    @IBOutlet var curLatitude: UILabel!
    @IBOutlet var curAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()  //once location updated trigger another function
        
        
        
        let latitute:CLLocationDegrees = 37.220968
        let longtitute: CLLocationDegrees = -93.285724
        
        //zoom in for latitute
        let latDelta: CLLocationDegrees = 0.01
        //zoom in for longtitue
        let longDelta: CLLocationDegrees = 0.01
        // it is zoom in size for area
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        //set up location using lat and long
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitute, longtitute)
        
        //set up region in map view according to location and span (zoom in size)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Drury University"
        annotation.subtitle = "That's my college"
        map.addAnnotation(annotation)
        
        //long press
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.action(_:)))
        uilpgr.minimumPressDuration = 1
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let userLocation: CLLocation = locations[0]
        
        print(userLocation)
        
        
        //zoom in for latitute
        let latDelta: CLLocationDegrees = 0.01
        //zoom in for longtitue
        let longDelta: CLLocationDegrees = 0.01
        // it is zoom in size for area
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        //set up location using lat and long
        let location: CLLocationCoordinate2D = userLocation.coordinate
        
        //set up region in map view according to location and span (zoom in size)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "I am moving"
        map.addAnnotation(annotation)
        
        curLatitude.text = String(userLocation.coordinate.latitude)
        curLongtitude.text = String(userLocation.coordinate.longitude)
        curSpeed.text = String(userLocation.speed)
        curCourse.text = String(userLocation.course)
        curAltitude.text = String(userLocation.altitude)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (result, error) in
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                
            }
            
            
            if result!.count > 0 {
                let pm = result![0]
                self.curAddress.text = pm.name
                
            }
            else {
                print("Problem with the data received from geocoder")
            }
        }
    }
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        
        let touchPoint  = gestureRecognizer.locationInView(self.map)
        let newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "Drury University"
        annotation.subtitle = "That's my college"
        map.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

