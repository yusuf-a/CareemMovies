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
    
    override func setUp() {
        super.setUp()
		
		movieSearchHTTPRequestFactory = MovieSearchHTTPRequestFactory(urlRequestFactory: <#T##URLRequestFactory#>)
    }
}
