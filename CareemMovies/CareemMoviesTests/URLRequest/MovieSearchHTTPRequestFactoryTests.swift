//
//  MovieSearchHTTPRequestFactoryTests.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 27/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import XCTest

@testable import CareemMovies

class MovieSearchHTTPRequestFactoryTests: XCTestCase {
	
	var movieSearchHTTPRequestFactory: MovieSearchHTTPRequestFactory!
	var mockURLRequestFactory: MockURLRequestFactory!
    
    override func setUp() {
        super.setUp()
		
		mockURLRequestFactory = MockURLRequestFactory()
		
		movieSearchHTTPRequestFactory = MovieSearchHTTPRequestFactory(urlRequestFactory: mockURLRequestFactory)
    }
	
	func test_searchForMovie_ReturnsExpectedURL() {
		
		let testSearchTerm = "batman"
		
		do {
			
			let request = try movieSearchHTTPRequestFactory.search(forMovie: testSearchTerm)
			XCTAssertEqual(request.url?.absoluteString, "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman")
		}
		
		catch {
			
			XCTFail()
		}
	}
}
