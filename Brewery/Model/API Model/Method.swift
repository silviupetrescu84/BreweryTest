//
//  Method.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/11/20.
//

import Foundation

struct Temp: Codable {
    var value: Int = 0
    var unit: String = ""
}

struct Mash_Temp: Codable {
    var temp: Temp = Temp()
    var duration: Int?
}

struct Fermentation: Codable {
    var temp: Temp = Temp()
}

struct Method: Codable {
    var mash_temp: [Mash_Temp]?
    var fermentation: Fermentation?
    var twist: String?
}
