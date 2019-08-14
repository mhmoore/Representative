//
//  StateListTableViewController.swift
//  Representative
//
//  Created by Michael Moore on 8/14/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class StateListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of rows")
        return States.all.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        
        let state = States.all[indexPath.row]
        
        cell.textLabel?.text = state
        print("items given to all the rows")
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        
        if segue.identifier == "toRepDetailTBVC" {
            guard let index = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? StateDetailTableViewController else { return }
                let state = States.all[index.row]
                destinationVC.state = state
            }
        }
}
