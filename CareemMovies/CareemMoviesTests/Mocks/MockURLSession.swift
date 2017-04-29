//
//  MockURLSession.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 26/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

class MockUrlSession: URLSession {
	
	var statusCode: Int?
	var dataToReturn: Data?
	var error: NSError?
	
	override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		
		if let error = error {
			
			let response = HTTPURLResponse(url: URL(string: "www.careem.com")!, statusCode: statusCode!, httpVersion: nil, headerFields: nil)
			completionHandler(nil, response, error)
		}
		
		if let _ = statusCode, let data = dataToReturn {
			
			completionHandler(data, nil, nil)
		}
		
		return MockUrlSessionDataTask()
	}
}
