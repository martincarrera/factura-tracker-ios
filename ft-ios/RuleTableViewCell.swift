//
//  RuleTableViewCell.swift
//  ft-ios
//
//  Created by Martin on 25/1/17.
//  Copyright © 2017 Martin. All rights reserved.
//

import UIKit

class RuleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ruleDescriptionLabel: UILabel!
    @IBOutlet weak var ruleCreatorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
