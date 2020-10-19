//
//  AlamoService.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/3/20.
//

import Foundation
import Alamofire
class AlamoService: CloudService  {
    func get(endpoint: String, parameters: [String:Any] = [:], completion: @escaping (Error?, Any?) -> Void) -> Void {
    
        AF.request(endpoint,method: .get, parameters: parameters)
          .validate(statusCode: 200..<300)
          .response { response in
            completion(response.error, response.data)
        }
    }
}
