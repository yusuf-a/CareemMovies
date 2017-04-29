//
//  MoviesURLRequestFactory.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 26/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import XCTest

@testable import CareemMovies

class MoviesURLRequestFactoryTests: XCTestCase {
	
	var urlRequestFactory: DefaultURLRequestFactory!
    
    override func setUp() {
        super.setUp()
		
		urlRequestFactory = DefaultURLRequestFactory()
    }
    
    override func tearDown() {
		
		urlRequestFactory = nil
        super.tearDown()
    }
	
	func testExpectedURL_IsReturned_WithParamaters() {
		
		let expectedString = "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman"
		
		let expectedURL = URL(string: expectedString)
		
		let urlRequest = URLRequest(url: expectedURL!)
		
		let httpParams = [["query": "batman"]]
		
		let urlRequestFactoryURL = urlRequestFactory.makeURLRequest(withPath: "search/movie", httpParams: httpParams)
		
		XCTAssertEqual(urlRequest, urlRequestFactoryURL)
	}
	
	func testURLRequestFactory_ReturnsNil_InvalidPath() {
		
		let urlRequestFactoryUrl = urlRequestFactory.makeURLRequest(withPath: "<", httpParams: [["key": "value"]])
		
		XCTAssertNil(urlRequestFactoryUrl)
	}
}
