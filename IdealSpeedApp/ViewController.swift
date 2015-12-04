//
//  ViewController.swift
//  IdealSpeedApp
//
//  Created by Mattias Bowallius on 16/11/15.
//  Copyright © 2015 MBApplications. All rights reserved.
//

import UIKit
import CoreLocation
import WatchConnectivity

class ViewController: UIViewController, CLLocationManagerDelegate, WCSessionDelegate {
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var goFasterImageView: UIImageView!
    @IBOutlet weak var goSlowerImageView: UIImageView!
    @IBOutlet weak var idealSpeedLabel: UILabel!
    
    var locationManager : MyCoreLocationManager!
    
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = MyCoreLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.activityType = CLActivityType.Fitness
        refreshUI()
        
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refreshUI()
    }
    
    @IBAction func startButtonPressed(sender: AnyObject) {
        if(!locationManager.isUpdating){
            locationManager.startUpdatingLocation()
            startButton.setTitle("Stop", forState: UIControlState.Normal)
        }else{
            locationManager.stopUpdatingLocation()
            startButton.setTitle("Start", forState: UIControlState.Normal)
            AppDelegate.speedCalculator.reset()
            
            //Needs to be refreshed separately since we want to show the latest distance travelled until we start again.
            speedLabel.text = String(format: "%.2f kph", AppDelegate.speedCalculator.latestSpeedInKph)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location updated")
        let location = locations.last
        AppDelegate.speedCalculator.latestLocation = location
        refreshUI()
        if session != nil && session!.reachable {
            session?.sendMessage(["speed":AppDelegate.speedCalculator.latestSpeedInKph],
                replyHandler: {(response) -> Void in print(response)},
                errorHandler:{(error) -> Void in print(error)})
        }
    }
    
    func refreshUI(){
        speedLabel.text = String(format: "%.2f kph", AppDelegate.speedCalculator.latestSpeedInKph)
        
        //Truncate the number of meters since we do not want to round up to the next meter once we pass the half meter point.
        distanceLabel.text = String(format: "%.0f m", AppDelegate.speedCalculator.distanceTravelled)
        idealSpeedLabel.text = String(format: "Ideal Speed: %.0f kph", AppDelegate.speedCalculator.idealSpeed * 60 * 60 / 1000)
        
        switch AppDelegate.speedCalculator.speedStatus{
        case SpeedStatus.TooFast:
            goFasterImageView.hidden = true
            goSlowerImageView.hidden = false
        case .TooSlow:
            goFasterImageView.hidden = false
            goSlowerImageView.hidden = true
        case .Good:
            goFasterImageView.hidden = true
            goSlowerImageView.hidden = true
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        dispatch_async(dispatch_get_main_queue(), {
            replyHandler(["speed":AppDelegate.speedCalculator.latestSpeedInKph])
        })
    }
    
}

