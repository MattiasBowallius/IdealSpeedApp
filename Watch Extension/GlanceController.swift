//
//  GlanceController.swift
//  Watch Extension
//
//  Created by Mattias Bowallius on 19/11/15.
//  Copyright © 2015 MBApplications. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet var distanceLable: WKInterfaceLabel!
    @IBOutlet var speedUpImage: WKInterfaceImage!
    @IBOutlet var slowDownImage: WKInterfaceImage!
    @IBOutlet var speedLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        slowDownImage.description = CGAffineTransformMakeRotation(CGFloat(M_PI))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
