//
//  ManualDataViewController.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/8/20.
//

import Foundation
import UIKit

class ManualDataViewController : UIViewController {
    var beerTypes: Int = 0
    var brewery: Brewery?
    @IBOutlet weak var beerTypesStepper: UIStepper!
    @IBOutlet weak var beerTypesLabel: UILabel!
    @IBOutlet weak var beerDataTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        beerTypesStepper.accessibilityIdentifier = "beerTypesStepper"
    }
        
    @IBAction func beerTypeStepperChanged(_ sender: Any) {
        if let stepper = sender as? UIStepper {
            beerTypes = Int(stepper.value)
        }
        beerTypesLabel.text = "Beer Types: " + String(beerTypes)
    }
    
    @IBAction func mixBeersButtonTapped(_ sender: Any) {
        guard beerTypes > 0 else { UIAlertController.showMessage(title: "No beers", message: "Please increase the number of beers"); return }
        guard !(beerDataTextfield.text?.isEmpty ?? true) else {UIAlertController.showMessage(title: "No customer", message: "Please enter the customers, new line separated"); return}
        if beerDataTextfield.text != nil {
            brewery = Brewery(beerTypes: beerTypes, customersData: beerDataTextfield.text!)
            guard !brewery!.customerWishes.isEmpty else { UIAlertController.showMessage(title: "Invalid data", message: "Please enter the customer data in the format 1 C 2 B 3 C"); return }
            performSegue(withIdentifier: "mixBeersSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mixBeersSegue", let vc = segue.destination as? ResultsViewController {
            vc.solutionType = .local
            vc.brewery = brewery!
        }
    }
}
