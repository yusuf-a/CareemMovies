//
//  MockURLRequestFactory.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 27/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

@testable import CareemMovies

enum State {
	
	case success
	case fail
}

class MockURLRequestFactory: DefaultURLRequestFactory {
	
	var state: State = .success
	
	override func makeURLRequest(withPath path: String, httpParams: [[String: String]]) -> URLRequest? {
		
		if case .success = state {
			
			return super.makeURLRequest(withPath: path, httpParams: httpParams)
		}
			
		else {
			
			return nil
		}
	}
}
