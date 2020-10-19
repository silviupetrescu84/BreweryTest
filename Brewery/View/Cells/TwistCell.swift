//
//  TwistCell.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/8/20.
//

import Foundation
import UIKit

class TwistCell : UITableViewCell {
    @IBOutlet weak var twistLabel: UILabel!
    
    func update(twist: String) {
        twistLabel.text = "Twist:" + twist
    }
}
