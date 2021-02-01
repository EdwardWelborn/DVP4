//
//  GamesTableViewCell.swift
//  MyGameLib
//
//  Created by Roy Welborn on 1/29/21.
//

import UIKit

class GamesTableViewCell: UITableViewCell {

    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameGenreLabel: UILabel!
    @IBOutlet weak var gameConsoleLabel: UILabel!
    @IBOutlet weak var gameFinishedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
