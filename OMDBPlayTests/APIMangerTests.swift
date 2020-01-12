//
//  APIMangerTests.swift
//  OMDBPlayTests
//
//  Created by Rohit Saini on 12/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import XCTest
@testable import OMDBPlay

class APIMangerTests: XCTestCase {
    
    var sut: APIManager!
    var apiSut: URLSession!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = APIManager()
        apiSut =  URLSession(configuration: .default)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        apiSut = nil
        super.tearDown()
    }

    //Checking internet availablility
    func testInternetConnection(){
        let internet = sut.checkInternetConnection()
        XCTAssertTrue(internet)
    }
    //Testing http response success or not
    func testValidAPICallToGetsHTTPStatusCode200(){
        //Given Url
        let url =
        URL(string: API.endPoint)
           // 1
           //Expecting the success response output
           let promise = expectation(description: "Status code: 200")

           // when
        let dataTask = apiSut.dataTask(with: url!) { data, response, error in
             // then
             if let error = error {
               XCTFail("Error: \(error.localizedDescription)")
               return
             } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
               if statusCode == 200 {
                 // 2
                 //Success
                 promise.fulfill()
               } else {
                 XCTFail("Status code: \(statusCode)")
               }
             }
           }
           dataTask.resume()
           // 3
           //waiting for 5 sec to complete the request
           wait(for: [promise], timeout: 5)
           
    }
   

}
