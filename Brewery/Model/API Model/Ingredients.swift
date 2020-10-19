//
//  Ingredients.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/11/20.
//

import Foundation

struct Amount: Codable {
    var value : Double = 0.0
    var unit: String = ""
}

struct Malt: Codable {
    var name: String = ""
    var amount: Amount = Amount()
}

struct Hops: Codable {
    var name: String = ""
    var amount: Amount = Amount()
    var add: String = ""
    var attribute: String = ""
}

struct Ingredients: Codable {
    var malt: [Malt]?
    var hops: [Hops]?
    var yeast: String?
}
