//
//  CancellationsViewController.swift
//  InclusiveCheck
//
//  Created by Isha Nagireddy on 9/18/23.
//

import UIKit

class CancellationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // ui variable
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // reload data when information from firebase is recieved
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // there will be 10 cells
        return AccountHomeViewController.top10Cancellations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // each cell will display the name of rider or driver in a cancelled ride
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let cancellation = AccountHomeViewController.top10Cancellations[indexPath.row]
        cell.textLabel?.text = String(indexPath.row + 1) + ". " + cancellation
        return cell
    }
}
