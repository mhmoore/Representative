//
//  RepresentativeTableViewCell.swift
//  Representative
//
//  Created by Michael Moore on 8/14/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class RepresentativeTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var officeLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    
    var representative: Representative? {
        didSet {
          updateViews()
        }
    }
    
    
    func updateViews() {
        if let representative = representative {
            nameLabel.text = representative.name
            districtLabel.text = representative.district
            linkLabel.text = representative.link
            officeLabel.text = representative.office
            phoneNumberLabel.text = representative.phone
            partyLabel.text = representative.party
        }
    }

}
