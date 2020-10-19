//
//  MaltCell.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/8/20.
//

import Foundation
import UIKit

class MaltCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ammountLabel: UILabel!
    
    func update(malt: Malt) {
        nameLabel.text = malt.name
        ammountLabel.text = String(malt.amount.value ) + " " + String(malt.amount.unit)
    }
}
