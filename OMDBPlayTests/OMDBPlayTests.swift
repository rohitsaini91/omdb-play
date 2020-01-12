//
//  OMDBPlayTests.swift
//  OMDBPlayTests
//
//  Created by Rohit Saini on 12/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import XCTest
@testable import OMDBPlay

class OMDBPlayTests: XCTestCase {

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Testing PostListing VC Collection view init successfully or not
    func testInitMyCollectionView(){
        let vc = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "PosterListVC") as! PosterListVC
        _ = vc.view
        XCTAssertNotNil(vc.collectionView)
    }
    
   
    
    
}
