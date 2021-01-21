//
//  ConsoleTableViewCell.swift
//  MyGameLib
//
//  Created by Roy Welborn on 1/20/21.
//

import UIKit

class ConsoleTableViewCell: UITableViewCell {

    @IBOutlet weak var consoleName: UILabel!
    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var datePurchased: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
