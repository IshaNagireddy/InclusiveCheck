//
//  ViewController.swift
//  InclusiveCheck
//
//  Created by Isha Nagireddy on 9/18/23.
//

import UIKit

class ViewController: UIViewController {
    
    // states whether the user is a rider or driver
    static var userType = ""
    
    @IBOutlet weak var driverButton: UIButton!
    @IBOutlet weak var riderButton: UIButton!
    
    // when screen is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // when the driver button is clicked, assign type to user
    @IBAction func driverClicked(_ sender: Any) {
        ViewController.userType = "Driver"
    }
    
    // when the rider button is clicked, assign type to user
    @IBAction func riderClicked(_ sender: Any) {
        ViewController.userType = "Rider"
    }
}

