//
//  AccountHomeViewController.swift
//  InclusiveCheck
//
//  Created by Isha Nagireddy on 9/18/23.
//

import UIKit
import FirebaseDatabase

class AccountHomeViewController: UIViewController {
    
    // ui variables
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cancellationsButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    
    var ref: DatabaseReference!
    
    // save the ten most recent cancellations
    static var top10Cancellations: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display name
        var shortName = LogInPageViewController.name
        shortName = shortName.components(separatedBy: "@")[0]
        nameLabel.text = shortName
        
        // access firebase database
        ref = Database.database().reference()
        ref.child(shortName + " " + ViewController.userType).observe(.value, with: { (snapshot) in
            let value = snapshot.value as? [String: String]
            
            // if no data is returned, alert the user that they logged into the wrong account type
            if (value?.keys ==  nil) {
                let dialogMessage = UIAlertController(title: "Incorrect account type", message: "Please try logging in again with the correct account type chosen.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                })
            
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            }
            
            // else, save the most recent cancellations to an array
            else {
                let keys = Array((value?.keys)!)
                AccountHomeViewController.top10Cancellations = keys
                print(AccountHomeViewController.top10Cancellations)
            }
            
            // else print an error
            }) { (error) in
                    print(error.localizedDescription)
        }
    }
}
