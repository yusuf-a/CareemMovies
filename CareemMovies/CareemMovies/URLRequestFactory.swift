//
//  MoviesURLRequestFactory.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 26/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

protocol URLRequestFactory {

	func makeURLRequest(withPath path: String, httpParams: [[String: String]]) -> URLRequest?
}

enum FindingDataType: String {
	
	case search = "search"
	case discover = "discover"
	case find = "find"
}

enum ContentType: String {
	
	case movies = "movie"
	case tv = "tv"
}

enum Strings {
	
	static let apiKeyKey = "api_key"
	static let apiKeyValue = "2696829a81b1b5827d515ff121700838"
	static let baseURL = "http://api.themoviedb.org/3"
}

class DefaultURLRequestFactory: URLRequestFactory {
	
	func makeURLRequest(withPath path: String, httpParams: [[String: String]]) -> URLRequest? {
		
		let urlString = "\(Strings.baseURL)/\(path)"
		
		guard let url = URL(string: urlString) else {
			
			return nil
		}
		
		var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
		
		let apiKeyHTTPParam = [[Strings.apiKeyKey: Strings.apiKeyValue]]
		let allhttpParams = apiKeyHTTPParam + httpParams
		
		let queryItems = generateQueryItems(fromDictionary: allhttpParams)
		
		urlComponents?.queryItems = queryItems
		
		guard let urlWithHttpParams = urlComponents?.url else {
			
			return nil
		}
		
		return URLRequest(url: urlWithHttpParams)
	}
	
	private func generateQueryItems(fromDictionary dictionary: [[String: String]]) -> [URLQueryItem] {
		
		var queryItems = [URLQueryItem]()
		
		for param in dictionary {
			
			for (name, value) in param {
				
				let  queryItem = URLQueryItem(name: name, value: value)
				
				queryItems.append(queryItem)
			}
		}
		return queryItems
	}
}
