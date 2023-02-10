//
//  CustomCellTableViewCell.swift
//  ContactManagerUI
//
//  Created by 김용재 on 2023/02/10.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var contactPhoneNumberValue: UILabel!
    @IBOutlet weak var contactAgeValue: UILabel!
    @IBOutlet weak var contactNameValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
