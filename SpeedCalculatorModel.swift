//
//  SpeedCalculatorModel.swift
//  IdealSpeedApp
//
//  Created by Mattias Bowallius on 16/11/15.
//  Copyright © 2015 MBApplications. All rights reserved.
//

import Foundation
import CoreLocation

class SpeedCalculatorModel{
    
    /**
     The total distance travelled since the last reset. Measured in meters.
     */
    var distanceTravelled : Double = 0.0
    
    /**
     The latest location used for speed calculation and measuring the distance travelled
     */
    var latestLocation : CLLocation!{
        willSet(newLocation){
            if(newLocation != nil){
                if let previousLocation = latestLocation{
                    let distance = newLocation.distanceFromLocation(previousLocation)
                    distanceTravelled += distance
                }
            }
        }
    }
    
    /**
     Returns the latest measured speed in m/s
     */
    var latestSpeed : CLLocationSpeed!{
        get{
            if let previousLocation = latestLocation{
                return previousLocation.speed
            }else{
                return 0
            }
        }
    }
    
    /**
     Resets the SpeedCalculatorModel to it's original state
     */
    func reset(){
        latestLocation = nil
        distanceTravelled = 0.0
    }
}