//
//  HTTPServiceTests.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 25/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import XCTest

@testable import CareemMovies

class HTTPServiceTests: XCTestCase {
	
	var httpService: HTTPService!
	var mockUrlSession: MockUrlSession!
    
    override func setUp() {
		super.setUp()
		
		mockUrlSession = MockUrlSession()
		httpService = HTTPService(urlSession: mockUrlSession)
    }
    
    override func tearDown() {
		
		mockUrlSession = nil
		httpService = nil
		
        super.tearDown()
    }
    
	func testDataTask_WithSuccessfulRequest_CallsSuccessCallBack() {
		
		let statusCodeToSet = 200
		var statusCodeFromCallback: Int? = nil
		var responseFromCallback: [String: Any]? = nil
		
		mockUrlSession.statusCode = 200
		mockUrlSession.dataToReturn = try! JSONSerialization.data(withJSONObject: ["Key": "Value"], options: .prettyPrinted)
		
		let successCallback:  HTTPService.APICallbackSuccess = {
			data in
			
			responseFromCallback = ["Key": "Value"]
			statusCodeFromCallback = statusCodeToSet
		}
		
		let request = URLRequest(url: URL(string: "http://www.careem.com")!)
		
		let _ = httpService.performDataTask(with: request, successCallback: successCallback, errorCallback: nil)
		
		XCTAssertEqual(statusCodeFromCallback, statusCodeToSet)
		XCTAssertEqual(responseFromCallback as! [String: String], ["Key": "Value"])
	}
	
	func testDataTask_WithFailureRequest_CallsErroCallback() {
		
		let statusCodeToSet = 404
		let errorToSet = NSError(domain: "test", code: 111, userInfo: nil)
		
		var statusCodeFromCallback = 0
		var errorFromCallback: NSError? = nil
		
		mockUrlSession.statusCode = statusCodeToSet
		mockUrlSession.dataToReturn = nil
		mockUrlSession.error = errorToSet
		
		let errorCallback:  HTTPService.APIErrorCallback = {
			statusCode, data, error in
			
			statusCodeFromCallback = statusCode
			errorFromCallback = errorToSet
		}
		
		let request = URLRequest(url: URL(string: "http://www.careem.com")!)
		
		let _ = httpService.performDataTask(with: request, successCallback: nil, errorCallback: errorCallback)
		
		XCTAssertEqual(statusCodeFromCallback, statusCodeToSet)
		XCTAssertEqual(errorFromCallback, errorToSet)
	}
	
	func testResumeWasCalled_OnDataTask() {
		
		let request = URLRequest(url: URL(string: "http://www.careem.com")!)
		
		let dataTask = httpService.performDataTask(with: request, successCallback: nil, errorCallback: nil) as! MockUrlSessionDataTask
		
		XCTAssertTrue(dataTask.resumeWasCalled)
	}
}
