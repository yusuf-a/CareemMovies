//
//  ResultsTests.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 25/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import XCTest

@testable import CareemMovies

class ResultsTests: XCTestCase {
	
	var movies: Movies!
    
    override func setUp() {
        super.setUp()
		
		let url = Bundle(for: CareemMoviesTests.self).url(forResource: "Movies", withExtension: "json")!
		let data = try! Data(contentsOf: url)
		let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
		
		movies = Movies(json: json)
	}
	
	func test_results_setsMovies() {
		
		XCTAssertNotNil(movies.results)
		XCTAssertEqual(movies.results?.count, 2)
	}
}
