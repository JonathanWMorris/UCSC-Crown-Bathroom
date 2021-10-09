//
//  UCSC_Crown_BathroomTests.swift
//  UCSC Crown BathroomTests
//
//  Created by Jonathan Morris on 9/3/21.
//

import XCTest
@testable import UCSC_Crown_Bathroom

class UCSC_Crown_BathroomTests: XCTestCase {
    
    var contentViewModel = ContentViewModel()
    var floorViewModel = FloorViewModel()
    var showersViewModel = ShowersViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        contentViewModel = ContentViewModel()
        floorViewModel = FloorViewModel()
        showersViewModel = ShowersViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetHomes() throws {
        contentViewModel.getHouseListData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            XCTAssert(self.contentViewModel.houses.isEmpty == false)
        }
    }
    
    func testGetFloors() throws {
        floorViewModel.getFloors(chosenHouse: "Descartes")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssert(self.floorViewModel.floors.count == 3)
        }
    }
    
    func testGetShowers() throws {
        showersViewModel.getShowersInfo(house: "Descartes", floor: "First")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssert(self.showersViewModel.showers.count == 3)
        }
    }
}
