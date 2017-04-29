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
	var fetchRecentSearchesWasCalled = false
	
	override func addRecentSearch(withSearchterm searchTerm: String) {
		
		addRecentSearchWasCalled = true
	}
	
	override func fetchRecentSearches() -> [RecentSearchViewModel] {
		
		fetchRecentSearchesWasCalled = true
		
		return [RecentSearchViewModel(searchTerm: "")]
	}
}
