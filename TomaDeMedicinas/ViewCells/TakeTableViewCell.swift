//
//  TakeTableViewCell.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 15/12/21.
//

import UIKit

class TakeTableViewCell: UITableViewCell {
    
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var medicationNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var quantity: UILabel!
    @IBOutlet var unit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
