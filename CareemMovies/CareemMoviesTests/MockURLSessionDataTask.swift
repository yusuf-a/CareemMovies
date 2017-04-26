//
//  MockURLSessionDataTask.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 26/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

class MockUrlSessionDataTask: URLSessionDataTask {
	
	var resumeWasCalled = false
	
	override func resume() {
		
		resumeWasCalled = true
	}
}

