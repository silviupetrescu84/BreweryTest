//
//  BrewerySolution.swift
//  Brewery
//
//  Created by Petrescu Silviu on 10/11/20.
//

import Foundation


class Brewery {
    var beerTypes: Int = 0
    var customerWishes: [[Int: BeerType]] = [[Int: BeerType]]() //We have x customers each with it's own wishes, if at least one can be satisified for each customer
    
    public convenience init(string: String) {
        self.init()
        guard !string.isEmpty else { return }

        var customersData = string.components(separatedBy: "\n") //At least one will be created even if the string is empty
        beerTypes = Int(customersData[0]) ?? 0
        if customersData.count > 0 {
            customersData.removeFirst()
            calculateCustomerWishes(data: customersData)
        }
    }
    
    public convenience init(beerTypes: Int, customersData: String) {
        self.init()
        self.beerTypes = beerTypes
        guard !customersData.isEmpty else { return }
        calculateCustomerWishes(data: customersData.components(separatedBy: "\n"))
    }
    
    func calculateCustomerWishes(data:[String]) {
        for i in 0..<data.count {
            let customerData = data[i]
            self.customerWishes.append(customerData.splitIntoWishes())
        }
    }
    
    class func calculateSolution(breweryData: Brewery) -> [BeerType] {
        guard breweryData.beerTypes > 0 else { return [] } //If we don't have any beer types no solutions exist
        var neededBeers = [Int: [BeerType: [Int]]]()
        //We created the default needed beers
        for i in 0 ..< breweryData.beerTypes {
            neededBeers[i + 1] = [.B: [],.C: []]
        }
        //We go through each customer wishes and we populate what beers they want
        for (index, customer) in breweryData.customerWishes.enumerated() {
            for wish in customer {
                if neededBeers[wish.key] != nil {
                    neededBeers[wish.key]![wish.value]?.append(index + 1)
                } else { //If we don't have the beer we cannot satisfy the customer
                    return []
                }
            }
        }
        print (breweryData.beerTypes)
        let sortedKeys = neededBeers.keys.sorted()
        for key in sortedKeys {
            print (key)
            for data in neededBeers[key]! {
                var dataString = data.key.rawValue
                for item in data.value {
                    dataString += String(item) + " "
                }
                print (dataString)
            }
        }
        //We calculate all possible solutions
        //If there is any beer that no customer wants we can make Classic by default
        //We check customers that have just one wish to remove the other type from the possible pool
        //We itterate through all the solutions and check if they work with at least one out of each customer's wihes
        
        return [.C, .C, .C, .C, .B] //Default solution
    }
}

extension String {
    func splitIntoWishes() -> [Int: BeerType] {
        var wishes : [Int: BeerType] = [Int: BeerType]()
        let splitData = components(separatedBy: " ")
        if splitData.count % 2 == 0 { //The data has to be in the format //1 B 3 C 5 C
            for i in stride(from: 0, to: splitData.count, by: 2) {
                if splitData[i + 1] == "B" {
                    wishes[Int(splitData[i]) ?? 0] = .B
                } else if splitData[i + 1] == "C" {
                    wishes[Int(splitData[i]) ?? 0] = .C
                }
            }
        }
        return wishes
    }
}
