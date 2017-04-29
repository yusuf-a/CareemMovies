//
//  MockHTTPService.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 27/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

@testable import CareemMovies

class MockHTTPService: HTTPService {
	
	var state: State = .success
	
	override func performDataTask(with request: URLRequest, successCallback: APICallbackSuccess?, errorCallback: APIErrorCallback?) -> URLSessionDataTask {
		
		if case .success = state {
			
			let url = Bundle(for: MockHTTPService.self).url(forResource: "Movies", withExtension: "json")!
			let data = try! Data(contentsOf: url)
			let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
			successCallback!(json)
			
		} else {
			
			errorCallback?(404, nil, NSError(domain: "", code: 9, userInfo: nil))
		}
		
		return MockUrlSessionDataTask()
	}
}
