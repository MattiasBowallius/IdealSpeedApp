//
//  GlanceController.swift
//  Watch Extension
//
//  Created by Mattias Bowallius on 19/11/15.
//  Copyright © 2015 MBApplications. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation


class SpeedInterfaceController: WKInterfaceController, WCSessionDelegate{
    
    @IBOutlet var distanceLabel: WKInterfaceLabel!
    @IBOutlet var speedUpImage: WKInterfaceImage!
    @IBOutlet var slowDownImage: WKInterfaceImage!
    @IBOutlet var speedLabel: WKInterfaceLabel!
    
    var session: WCSession!
    
    override func didAppear() {
        speedLabel.setText("hej")
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
            if(session.reachable){
                session.sendMessage([:], replyHandler: {(response) -> Void in
                    print("success")
                    if let speed = response["speed"] as? String{
                        self.speedLabel.setText(speed)
                    }
                    
                    }, errorHandler: {(error) -> Void in
                        print("\(error)")
                })
            }else{
                print("Phone not reachable")
            }
        }
    }
    
    func sessionReachabilityDidChange(session: WCSession) {
        print("Reachability is: \(session.reachable)")
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        dispatch_async(dispatch_get_main_queue(), {
            if let speed = message["speed"] as? Double{
                self.speedLabel.setText(String(speed))
            }
            
            if let distance = message["distance"] as? Double{
                self.distanceLabel.setText(String(distance))
            }
            
            if let speedStatusRaw = message["speedStatus"] as? String{
                if let speedStatus = SpeedStatus(rawValue: speedStatusRaw){
                    switch speedStatus{
                    case SpeedStatus.TooFast:
                        self.speedUpImage.setImage(nil)
                        self.slowDownImage.setImageNamed("Arrow down")
                    case .TooSlow:
                        self.speedUpImage.setImageNamed("Arrow up")
                        self.slowDownImage.setImage(nil)
                    case .Good:
                        self.speedUpImage.setImage(nil)
                        self.slowDownImage.setImage(nil)
                    }
                    
                }
            }
        })
    }
}