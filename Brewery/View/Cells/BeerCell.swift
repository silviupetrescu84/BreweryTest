//
//  BeerCell.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/8/20.
//

import Foundation
import UIKit
import AlamofireImage
                                    
class BeerCell : UITableViewCell {
    
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerABV: UILabel!
    @IBOutlet weak var beerType: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerImageViewSpinner: UIActivityIndicatorView!
    
    func update(beer: Beer){
        beerName.text = beer.name
        beerABV.text = String(beer.abv) + "%"
        beerType.text = beer.type
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
}
