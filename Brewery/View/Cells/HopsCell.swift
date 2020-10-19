//
//  HopsCell.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/8/20.
//

import Foundation
import UIKit

class HopsCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ammountLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    
    func update(hops: Hops) {
        nameLabel.text = hops.name
        ammountLabel.text = String(hops.amount.value ) + " " + String(hops.amount.unit)
        addLabel.text   = hops.add
        attributeLabel.text = hops.attribute
    }
}
