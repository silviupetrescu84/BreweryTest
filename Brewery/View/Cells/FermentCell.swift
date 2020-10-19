//
//  FermentCell.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/8/20.
//

import Foundation
import UIKit

class FermentCell : UITableViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func update(fermentation: Fermentation) {
        temperatureLabel.text = "Fermentation: " + String(fermentation.temp.value ) + " " + String(fermentation.temp.unit)
    }
}
