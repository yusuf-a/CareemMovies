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
		
		let url = Bundle(for: MovieTests.self).url(forResource: "Movie", withExtension: "json")!
		let data = try! Data(contentsOf: url)
		let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
		
		movie = Movie(json: json)
    }
	
	func test_movie_setsTitle() {
		
		XCTAssertEqual(movie.title, "Batman")
	}
	
	func test_movie_setsReleaseDate() {
		
		XCTAssertEqual(movie.releaseDate, "1989-06-23")
	}
	
	func test_movie_setsPosterPath() {
		
		XCTAssertEqual(movie.posterPath, "/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg")
	}
	
	func test_movie_setsOverview() {
		
		XCTAssertEqual(movie.overview, "The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham's underworld.")
	}
}
