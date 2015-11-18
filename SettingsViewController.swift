//
//  SettingsViewController.swift
//  IdealSpeedApp
//
//  Created by Mattias Bowallius on 17/11/15.
//  Copyright © 2015 MBApplications. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var idealSpeedTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         idealSpeedTextField.text = String(format: "%.0f", AppDelegate.speedCalculator.idealSpeed)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func stepperPressed(sender: UIStepper) {
        idealSpeedTextField.text = Int(sender.value).description
        AppDelegate.speedCalculator.idealSpeed = Double(sender.value) * 1000 / 60 / 60
    }
    
    @IBAction func touchUpInsideMainView(sender: AnyObject) {
        idealSpeedTextField.resignFirstResponder()
    }
    @IBAction func editingOfIdealSpeedStopped(sender: AnyObject) {
        
        if let valueOfTextField : Double? = Double(idealSpeedTextField.text!){
            AppDelegate.speedCalculator.idealSpeed = valueOfTextField! * 1000 / 60 / 60
        }
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
