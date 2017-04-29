//
//  MockRecentSearchManager.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 29/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

@testable import CareemMovies

class MockRecentSearchManager: RecentSearchesManager {
	
	var addRecentSearchWasCalled = false
	
	override func addRecentSearch(withSearchterm searchTerm: String) {
		
		addRecentSearchWasCalled = true
	}
}
