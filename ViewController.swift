//
//  ViewController.swift
//  IdealSpeedApp
//
//  Created by Mattias Bowallius on 16/11/15.
//  Copyright © 2015 MBApplications. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    let speedCalculator = SpeedCalculatorModel()
    var locationManager : MyCoreLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = MyCoreLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    @IBAction func startButtonPressed(sender: AnyObject) {
        if(!locationManager.isUpdating){
            locationManager.startUpdatingLocation()
            startButton.setTitle("Stop", forState: UIControlState.Normal)
        }else{
            locationManager.stopUpdatingLocation()
            startButton.setTitle("Start", forState: UIControlState.Normal)
            speedCalculator.reset()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updated location")
        let location = locations.last
        speedCalculator.latestLocation = location
        print("The current speed is: \(speedCalculator.latestSpeed)")
        speedLabel.text = "\(speedCalculator.latestSpeed) m/s"
        distanceLabel.text = "\(speedCalculator.distanceTravelled) m"
    }
}

