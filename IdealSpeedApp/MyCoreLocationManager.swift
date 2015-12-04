//
//  MyCoreLocationManager.swift
//  IdealSpeedApp
//
//  Created by Mattias Bowallius on 16/11/15.
//  Copyright © 2015 MBApplications. All rights reserved.
//

import Foundation
import CoreLocation

class MyCoreLocationManager: CLLocationManager {
    var isUpdating : Bool = false
    
    override func startUpdatingLocation() {
        super.startUpdatingLocation()
        isUpdating = true
    }
    
    override func stopUpdatingLocation() {
        super.stopUpdatingLocation()
        isUpdating = false
    }
}