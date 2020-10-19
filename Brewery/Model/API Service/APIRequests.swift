//
//  APIRequests.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/11/20.
//

import Foundation

enum PossibleServices {
    case Alamofire
    case NSURLSession
    case none
}

protocol APIRequests {
    func getBeers(for parameters: [String:String]?, completion: @escaping (Error?, Any?) -> Void)
    func getInput(for parameters: [String:String]?, completion: @escaping (Error?, Any?) -> Void)
}
