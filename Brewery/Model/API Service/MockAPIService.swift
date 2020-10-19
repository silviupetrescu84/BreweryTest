//
//  MockAPIService.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/11/20.
//

import Foundation

class MockAPIService: APIRequests {
    var mockBeersString = ""
    var mockSolutionString = ""
    required init() {
        if let filepath = Bundle.main.path(forResource: "Beers", ofType: "json") {
            do {
                mockBeersString = try String(contentsOfFile: filepath)
            } catch {
                print ("Error reading Beers.json")
            }
        } else {
            print ("File Beers.json not found")
        }
        if let filepath = Bundle.main.path(forResource: "example1", ofType: "txt") {
            do {
                mockBeersString = try String(contentsOfFile: filepath)
            } catch {
                print ("Error reading Beers.json")
            }
        } else {
            print ("File Beers.json not found")
        }
    }
    
    func getBeers(for parameters: [String:String]?, completion: @escaping (Error?, Any?) -> Void) {
        let data = mockBeersString.data(using: .utf8)
        let object = try! jsonDecoder.decode([Beer].self, from: data!)
        completion(nil, object)
    }
    
    func getInput(for parameters: [String : String]?, completion: @escaping (Error?, Any?) -> Void) {
        completion(nil, mockSolutionString)
    }
}
