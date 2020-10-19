//
//  BreweryTests.swift
//  BreweryTests
//
//  Created by Petrescu Silviu on 10/3/20.
//

import XCTest
@testable import Brewery

class BreweryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample1() throws {
        let file = fileRead(file: "example1.txt")
        let brewery = Brewery(string: file)
        let solution = Brewery.calculateSolution(breweryData: brewery)
        XCTAssertTrue(solution == [.C, .C, .C, .C, .B], "Example 1 failed")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension BreweryTests { //File reading

    func fileRead(file: String) -> String {
        
        let fm          = FileManager.default
        let filePath    = Bundle.main.path(forResource: file.fileName, ofType: file.fileExtension)
        
        if filePath != nil && fm.fileExists(atPath: filePath!) {
            let fileURL = Bundle.main.resourceURL!.appendingPathComponent(file)
            do {
                return try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {
                return ""
            }
        }
        
        return ""
    }
}
