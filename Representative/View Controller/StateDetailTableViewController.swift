//
//  StateDetailTableViewController.swift
//  Representative
//
//  Created by Michael Moore on 8/14/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class StateDetailTableViewController: UITableViewController {

    var state: String?
    
    var representatives: [Representative] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let state = state else {return}
        RepresentativeController.searchRepresentativeFor(state: state ) { (representatives) in
            DispatchQueue.main.async {
                self.representatives = representatives
            }
        }
    }

    // MARK: - Table view data source
    func reloadTableView() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        tableView.reloadData()
        }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representatives.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath) as? RepresentativeTableViewCell else { return UITableViewCell() }
        
        let rep = representatives[indexPath.row]
        
        cell.nameLabel.text = rep.name
        cell.districtLabel.text = rep.district
        cell.phoneNumberLabel.text = rep.phone
        cell.linkLabel.text = rep.link
        cell.partyLabel.text = rep.party
        cell.officeLabel.text = rep.office
        
        return cell
    }

}
