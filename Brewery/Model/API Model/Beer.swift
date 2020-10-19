//
//  Beer.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/8/20.
//

import Foundation

enum BeerType : String {
    case B = "Barrel" //Barrel
    case C = "Classic" //Classic
    case none = ""
}

struct Volume: Codable {
    var value: Int = 0
    var unit: String = ""
}

struct Beer : Codable {
    var id: Int = 0
    var name: String = ""
    var type: String?
    var tagline: String = ""
    var first_brewed: String = ""
    var description: String = ""
    var image_url: String = ""
    var abv: Double = 0.0
    var ibu: Double?
    var target_fg: Int = 0
    var target_og: Double = 0.0
    var ebc: Int?
    var srm: Double?
    var ph: Double?
    var attenuation_level: Double = 0.0
    var volume: Volume = Volume(value: 0, unit: "")
    var boil_volume: Volume = Volume(value: 0, unit: "")
    var method: Method?
    var ingredients: Ingredients?
    var food_pairing: [String] = [""]
    var brewers_tips: String = ""
    var contributed_by: String = ""
}
