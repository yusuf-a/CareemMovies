//
//  MovieTests.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 25/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import XCTest

@testable import CareemMovies

class MovieTests: XCTestCase {
	
	var movie: Movie!
    
    override func setUp() {
        super.setUp()
		
		let url = Bundle(for: CareemMoviesTests.self).url(forResource: "Movie", withExtension: "json")!
		let data = try! Data(contentsOf: url)
		let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
		
		movie = Movie(json: json)
    }
}
