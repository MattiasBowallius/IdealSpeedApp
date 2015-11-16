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
    var distanceTravelled : Double!
    var latestLocation : CLLocation!
    var latestSpeed : CLLocationSpeed!{
        get{
            return latestLocation.speed
        }
    }
    
    func reset(){
        latestLocation = nil
    }
}