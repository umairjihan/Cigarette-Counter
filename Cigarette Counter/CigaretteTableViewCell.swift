//
//  CigaretteTableViewCell.swift
//  Cigarette Counter
//
//  Created by Abu Umair Jihan on 1/1/18.
//  Copyright © 2018 Abu Umair Jihan. All rights reserved.
//

import UIKit
import CoreData
class CigaretteTableViewCell: UITableViewCell {

    @IBOutlet weak var cigaretteNameLabel: UILabel!
    @IBOutlet weak var cigarettePriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setDataToCell(shop:Cigarette){
        if let name = shop.name{
            self.cigaretteNameLabel.text = name
        }
        self.cigarettePriceLabel.text = String(shop.price)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
