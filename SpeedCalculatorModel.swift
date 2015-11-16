//
//  SpeedCalculatorModel.swift
//  IdealSpeedApp
//
//  Created by Mattias Bowallius on 16/11/15.
//  Copyright © 2015 MBApplications. All rights reserved.
//

import Foundation
import MapKit

class SpeedCalculatorModel{
 
    var previousCoordinate : MKMapPoint!
    var previousTime : NSDate!
    
    var currentCoordinate : MKMapPoint!
    var currentTime : NSDate!
    
    var latestSpeed : Double {
        get{
           return 0
        }
    }
}