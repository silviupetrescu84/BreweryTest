//
//  MashCell.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/8/20.
//

import Foundation
import UIKit

class MashCell : UITableViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var ammountLabel: UILabel!
    
    func update(mash_temp: Mash_Temp) {
        temperatureLabel.text = "Mash: " + String(mash_temp.temp.value) + " " + String(mash_temp.temp.unit)
        ammountLabel.text = "Duration: " + String(mash_temp.duration ?? 0)
    }
}
