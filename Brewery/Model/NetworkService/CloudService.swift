//
//  CloudService.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/3/20.
//

import Foundation

protocol CloudService {
    func get(endpoint: String, parameters: [String:Any], completion: @escaping (Error?, Any?) -> Void) -> Void
}
