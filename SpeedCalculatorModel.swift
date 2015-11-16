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
    var distanceTravelled : Double = 0.0
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
    var latestSpeed : CLLocationSpeed!{
        get{
            if let previousLocation = latestLocation{
                return previousLocation.speed
            }else{
                return 0
            }
        }
    }
    
    func reset(){
        latestLocation = nil
        distanceTravelled = 0.0
    }
}