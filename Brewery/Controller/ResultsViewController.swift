//
//  ResultsViewController.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/8/20.
//

import Foundation
import UIKit

enum SolutionType: Int {
    case local
    case download
    case none
}

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var solutionType: SolutionType = .download
    var brewery: Brewery?
    var beers : [Beer]?
    var solution: [BeerType]?
    var tappedIndex = 0
    @IBOutlet weak var solutionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        if solutionType == .download {
            downloadInput()
        } else if solutionType == .local {
            displaySolution()
        }
    }
    
    func downloadInput() {
        APIService.shared.getInput(for: [:], completion: { error, result in
            if let resultString = result as? String {
                DispatchQueue.main.async {
                    self.brewery = Brewery(string: resultString)
                    self.displaySolution()
                }
            }
        })
    }
    
    func displaySolution() {
        guard brewery != nil else { return }
        solution = Brewery.calculateSolution(breweryData: brewery!)
        solutionLabel.text = solution!.isEmpty ? "No solution exists" : "Solution: " + concatenateSolution()
        downloadBeerData()
    }
    
    func concatenateSolution() -> String {
        var string = ""
        for item in solution!.enumerated() {
            string += item.element.rawValue + " "
        }
        return string //There is an empty space at the end
    }
        
    func downloadBeerData() {
        APIService.shared.getBeers(for: [:], completion: { error, result in
            if let downloadedBeers = (result as? [Beer]) {
                DispatchQueue.main.async {
                    self.beers = downloadedBeers
                    for (index ,item) in self.solution!.enumerated() {
                        self.beers![index].type = item.rawValue
                    }
                    self.loadingIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard brewery != nil else { return 0 }
        guard beers != nil else { return 0 }
        return brewery!.beerTypes
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerCell
        if indexPath.row < beers!.count {
            cell.update(beer: beers![indexPath.row])
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tappedIndex = indexPath.row
        return indexPath
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "beerCellTapSegue", let vc = segue.destination as? BeerDetailsViewController {
            vc.beer = beers![tappedIndex]
        }
    }
}
