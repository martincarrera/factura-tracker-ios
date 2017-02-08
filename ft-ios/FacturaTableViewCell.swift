//
//  FacturaTableViewCell.swift
//  ft-ios
//
//  Created by Martin on 25/1/17.
//  Copyright © 2017 Martin. All rights reserved.
//

import UIKit

class FacturaTableViewCell: UITableViewCell {

    @IBOutlet weak var isPayedImageView: UIImageView!
    @IBOutlet weak var guiltyNameLabel: UILabel!
    @IBOutlet weak var isExpiredImageView: UIImageView!
    @IBOutlet weak var creatorNameLabel: UILabel!
    @IBOutlet weak var ruleLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var validatedByLabel: UILabel!
    @IBOutlet weak var validatedByNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
