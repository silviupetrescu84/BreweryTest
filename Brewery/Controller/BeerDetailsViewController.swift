//
//  BeerDetailsViewController.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/8/20.
//

import Foundation
import UIKit
import AlamofireImage
class BeerDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var beer: Beer!
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerImageViewSpinner: UIActivityIndicatorView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerABV: UILabel!
    @IBOutlet weak var beerType: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        update()
    }
    
    func update() {
        beerName.text = beer.name
        beerABV.text = String(beer.abv) + "%"
        beerType.text = beer.type
        descriptionLabel.text = beer.description
        beerImageViewSpinner.startAnimating()
        beerImageView.image = nil
        downloadImage(string: beer.image_url)
    }
    
    func downloadImage(string: String) {
            let downloader = ImageDownloader()
            let urlRequest = URLRequest(url: URL(string: string)!)

            downloader.download(urlRequest, completion:  { response in
                //print(response.request ?? "")
                //print(response.response ?? "")
                //debugPrint(response.result)
                
                if case .success(let image) = response.result {
                    DispatchQueue.main.async {
                        self.beerImageView.image =  image
                        self.beerImageViewSpinner.stopAnimating()
                    }
                }
            })
        
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return beer.ingredients?.hops?.count ?? 0
        } else if segmentControl.selectedSegmentIndex == 1 {
            return beer.ingredients?.malt?.count ?? 0
        } else if segmentControl.selectedSegmentIndex == 2 {
            var defaultRows = beer.method?.mash_temp?.count ?? 0
            defaultRows += beer.method?.fermentation != nil ? 1 : 0
            defaultRows += beer.method?.twist != nil ? 1 : 0
            return defaultRows
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hopsCell", for: indexPath)
        if segmentControl.selectedSegmentIndex == 0 {
            if let hopsCell = tableView.dequeueReusableCell(withIdentifier: "hopsCell", for: indexPath) as? HopsCell {
                hopsCell.update(hops: beer.ingredients!.hops![indexPath.row])
                return hopsCell
            }
        } else if segmentControl.selectedSegmentIndex == 1 {
            if let maltCell = tableView.dequeueReusableCell(withIdentifier: "maltCell", for: indexPath) as? MaltCell {
                maltCell.update(malt: beer.ingredients!.malt![indexPath.row])
                return maltCell
            }
        } else if segmentControl.selectedSegmentIndex == 2 {
            if indexPath.row < (beer.method?.mash_temp?.count ?? 0) {
                if let mashCell = tableView.dequeueReusableCell(withIdentifier: "mashCell", for: indexPath) as? MashCell {
                    mashCell.update(mash_temp: beer.method!.mash_temp![indexPath.row])
                    return mashCell
                }
            } else if beer.method?.fermentation != nil && indexPath.row < (beer.method?.mash_temp?.count ?? 0) + 1 {
                if let fermentCell = tableView.dequeueReusableCell(withIdentifier: "fermentCell", for: indexPath) as? FermentCell {
                    fermentCell.update(fermentation: beer.method!.fermentation!)
                    return fermentCell
                }
            } else if beer.method?.twist != nil {
                if let twistCell = tableView.dequeueReusableCell(withIdentifier: "twistCell", for: indexPath) as? TwistCell {
                    twistCell.update(twist: beer.method!.twist!)
                    return twistCell
                }
            }
        }
            
        return cell
    }
}
