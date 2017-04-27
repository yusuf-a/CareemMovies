//
//  MoviesSearchServiceTests.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 27/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import XCTest

@testable import CareemMovies

class MoviesSearchServiceTests: XCTestCase {
	
	var moviesSearchService: MoviesSearchService!
	var mockHTTPService: MockHTTPService!
	var mockMovieSearchHTTPRequestFactory: MockMovieSearchHTTPRequestFactory!
    
    override func setUp() {
        super.setUp()
		
		mockHTTPService = MockHTTPService(urlSession: MockUrlSession())
		mockMovieSearchHTTPRequestFactory = MockMovieSearchHTTPRequestFactory(urlRequestFactory: MockURLRequestFactory())
		
		moviesSearchService = MoviesSearchService(moviesSearchHTTPRequestFactory: mockMovieSearchHTTPRequestFactory, httpService: mockHTTPService)
    }
	
	override func tearDown() {
		
		moviesSearchService = nil
		mockHTTPService = nil
		mockMovieSearchHTTPRequestFactory = nil
		super.tearDown()
	}
	
	func test_searchMovie_httpRequestFactory_searchWasCalled() {
		
		try! moviesSearchService.search(forMovie: "test", successCallback: { (_) in
			
		}, errorCallback: { (_) in

		})
		
		XCTAssert(mockMovieSearchHTTPRequestFactory.searchWasCalled)
	}
	
	func test_searchMovie_callsSuccessCallback_withMovies() {
		
		let testMovie = "batman"
		
		mockHTTPService.state = .success
		
		try! moviesSearchService.search(forMovie: testMovie, successCallback: { (movieViewModels) in
			
			XCTAssertNotNil(movieViewModels)
			XCTAssertEqual(movieViewModels.count, 2)
			XCTAssertEqual(movieViewModels[0].title, "Batman")
			XCTAssertEqual(movieViewModels[0].imageUrl, "http://image.tmdb.org/t/p/w185//kBf3g9crrADGMc2AMAMlLBgSm2h.jpg")
			XCTAssertEqual(movieViewModels[0].releaseDate, "June 23, 1989")
			
		}) { (_) in
			XCTFail()
		}
	}
}
