//
//  MovieSearchHTTPRequestFactory.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 27/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

enum URLError: Error {
	
	case cannotFormURLRequest
}

protocol HTTPRequestFactory { }

class MovieSearchHTTPRequestFactory: HTTPRequestFactory {
	
	enum SearchHTTPParameterKeys {
	
		static let query = "query"
	}
	
	let urlRequestFactory: URLRequestFactory
	
	init(urlRequestFactory: URLRequestFactory) {
		
		self.urlRequestFactory = urlRequestFactory
	}
	
	func search(forMovie movie: String) throws -> URLRequest {
		
		let httpParams = [SearchHTTPParameterKeys.query: movie]
		
		let path = "\(FindingDataType.search.rawValue)/\(ContentType.movies.rawValue)"
		
		guard let url = urlRequestFactory.makeURLRequest(withPath: path, httpParams: [httpParams])?.url else {
			
			throw URLError.cannotFormURLRequest
		}
		
		return URLRequest(url: url)
	}
}
