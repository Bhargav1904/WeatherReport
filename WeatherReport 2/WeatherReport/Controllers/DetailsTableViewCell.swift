//
//  DetailsTableViewCell.swift
//  WeatherReport
//
//  Created by Bhargav on 4/23/23.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var DescriptionLbl:UILabel!
    @IBOutlet weak var icon:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
