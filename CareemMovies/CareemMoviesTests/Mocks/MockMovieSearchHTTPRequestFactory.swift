//
//  MockMovieSearchHTTPRequestFactory.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 27/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

@testable import CareemMovies

class MockMovieSearchHTTPRequestFactory: MovieSearchHTTPRequestFactory {
	
	var searchWasCalled = false
	
	override func search(forMovie movie: String) throws -> URLRequest {
		
		searchWasCalled = true
		
		return URLRequest(url: URL(string: "www.test.com")!)
	}
}
