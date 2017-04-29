//
//  HTTPService.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 25/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

class HTTPService {
	
	typealias APICallbackSuccess = ([String: Any]?) -> Void
	typealias APIErrorCallback = (Int, [String:Any]?, Error) -> Void
	
	let urlSession: URLSession
	
	init(urlSession: URLSession = URLSession.shared) {
		
		self.urlSession = urlSession
	}
	
	func performDataTask(with request: URLRequest, successCallback: APICallbackSuccess?, errorCallback: APIErrorCallback?) ->
		URLSessionDataTask {
			
			let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
				
				if let error = error, let errorCallback = errorCallback, let response = response as? HTTPURLResponse {
					
					errorCallback(response.statusCode, nil, error)
					
				} else {
					
					if let successCallback = successCallback, let data = data {
						
						successCallback(self.serialize(response: data))
					}
				}
			}
			
			dataTask.resume()
			
			return dataTask
	}
	
	private func serialize(response: Data) -> [String: Any]?  {
		
		let data = response
		
		var responseObject: Any?
		
		do {
			
			responseObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
			
		} catch {
			
			return nil
		}
		
		if let responseDictionary = responseObject as? [String: Any] {
			
			return responseDictionary
			
		} else {
			
			return nil
		}
	}
}
