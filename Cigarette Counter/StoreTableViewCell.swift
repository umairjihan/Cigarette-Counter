//
//  StoreTableViewCell.swift
//  Cigarette Counter
//
//  Created by Abu Umair Jihan on 1/1/18.
//  Copyright © 2018 Abu Umair Jihan. All rights reserved.
//

import UIKit
import CoreData
class StoreTableViewCell: UITableViewCell {

    @IBOutlet weak var storeNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDataToCell(shop:Store){
        if let name = shop.name {
            self.storeNameLabel.text = name
        }   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
