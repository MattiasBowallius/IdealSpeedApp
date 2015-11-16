//
//  ViewController.swift
//  IdealSpeedApp
//
//  Created by Mattias Bowallius on 16/11/15.
//  Copyright © 2015 MBApplications. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let speedCalculator = SpeedCalculatorModel()
    var locationManager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updated location")
        let location = locations.last
        speedCalculator.latestLocation = location
        print("The current speed is: \(speedCalculator.latestSpeed)")
    }
}

