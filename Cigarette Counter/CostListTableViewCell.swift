//
//  CostListTableViewCell.swift
//  Cigarette Counter
//
//  Created by Abu Umair Jihan on 1/2/18.
//  Copyright © 2018 Abu Umair Jihan. All rights reserved.
//

import UIKit

class CostListTableViewCell: UITableViewCell {

    @IBOutlet weak var cCount: UILabel!
    @IBOutlet weak var tCount: UILabel!
    @IBOutlet weak var cPrice: UILabel!
    @IBOutlet weak var tPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setDataToCell(cost:Cost){
        self.cCount.text = String(cost.c_count)
        self.tCount.text = String(cost.t_count)
        self.cPrice.text = String(cost.c_price * Float(cost.c_count))
        self.tPrice.text = String(cost.t_price * Float(cost.t_count))
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
