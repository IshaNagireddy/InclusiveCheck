//
//  ReportViewController.swift
//  InclusiveCheck
//
//  Created by Isha Nagireddy on 9/18/23.
//

import UIKit

class ReportViewController: UIViewController {
    
    //api key used for collecting data
    var apiKey = "95a7dbfbf1319b2082c52efc693c0132"
    static var origins: [Origin] = []
    
    // ui variables
    @IBOutlet weak var ridesCanceledLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display basic information about this screen
        ridesCanceledLabel.text = "Of the 10 mot recent rides that " + LogInPageViewController.name + " canceled"
        callingAPI()
        
        
    }
    
    func callingAPI(){
        
        // will count the number of names iterated over
        var counter = 0
        
        // count the number of names classified as non-white
        var ethnicNameCounter = 0
        
        // count the number of names classified as white
        var whiteNameCounter = 0
        for name in AccountHomeViewController.top10Cancellations {
            // seperate the name into first and last name
            let nameSeperated = name.components(separatedBy: " ")
            
            // namsor api - https://namsor.app/api-documentation
            // calling apis - https://www.advancedswift.com/http-requests-in-swift/#start-urlsessiondatatask
            let urlFormat = "https://v2.namsor.com/NamSorAPIv2/api2/json/origin/" + nameSeperated[0] + "/" + nameSeperated[1] + ""
            print(urlFormat)
            let url = URL(string: urlFormat)!
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = [
                "Content-Type": "application/json",
                "X-API-KEY": "95a7dbfbf1319b2082c52efc693c0132"
            ]
            
            URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
                guard error == nil else { return }
                guard let data = data, let _ = response else { return }
                let origin: Origin = try! JSONDecoder().decode(Origin.self, from: data)
                print(origin)
                
                // append origin to the list of origins
                ReportViewController.origins.append(origin)
                
                // if the name has European or Northern American origin
                if (origin.regionOrigin == "Europe" || origin.regionOrigin == "Northern America") {
                    whiteNameCounter += 1
                }
                
                // else if the name has other origin
                else {
                    ethnicNameCounter += 1
                }
                counter += 1
                
                // if all the names have been classified output a percentage
                if (counter == 10) {
                    DispatchQueue.main.async {
                        // calculating and formatting percentage
                        let percentage = ethnicNameCounter * 10
                        self.percentageLabel.text = String(percentage) + "%"
                        
                        // if percent is greater than 80, Uber will be notified
                        if (percentage >= 80) {
                            self.percentageLabel.textColor = UIColor.red
                            self.actionLabel.text = "Since this percentage is greater than 80%, Uber will be notified and take further action."
                        }
                        
                        // else, user will be thanked for upholding policies
                        else {
                            self.actionLabel.text = "No notification will be sent to Uber. Thank you for helping increase inclusivity!"
                        }
                        
                    }
                }
            }
            .resume()
        }
        
    }
}
