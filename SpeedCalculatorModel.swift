//
//  SpeedCalculatorModel.swift
//  IdealSpeedApp
//
//  Created by Mattias Bowallius on 16/11/15.
//  Copyright © 2015 MBApplications. All rights reserved.
//

import Foundation
import CoreLocation

enum SpeedStatus{
    case TooFast
    case Good
    case TooSlow
}

class SpeedCalculatorModel{
    
    /**
     The total distance travelled since the last reset. Measured in meters.
     */
    var distanceTravelled : Double = 0.0
    
    let speedTolerance : Double = 10
    
    /**
     Returns a status depicting whether the speed is too high, too low or within the tolerance for speed error.
     */
    var speedStatus : SpeedStatus{
        if latestSpeedInMps > idealSpeed + speedTolerance {
            return SpeedStatus.TooFast
        } else if latestSpeedInMps < idealSpeed - speedTolerance {
            return SpeedStatus.TooSlow
        } else {
            return SpeedStatus.Good
        }
    }
    
    /**
     The ideal speed used to calculate whether the user is going too fast, too slow or within the tolerance.
     */
    var idealSpeed : Double = 0.0
    
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
    var latestSpeedInMps : CLLocationSpeed!{
        get{
            if let previousLocation = latestLocation{
                return previousLocation.speed
            }else{
                return 0
            }
        }
    }
    
    /**
     Returns the latest measured speed in km/h
     */
    var latestSpeedInKph : CLLocationSpeed!{
        get{
            if let previousLocation = latestLocation{
                return previousLocation.speed * 60 * 60 / 1000
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