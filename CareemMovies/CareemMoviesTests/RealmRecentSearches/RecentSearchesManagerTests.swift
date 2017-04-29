//
//  RecentSearchesManagerTests.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 29/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import XCTest
import RealmSwift

@testable import CareemMovies

class RecentSearchesManagerTests: XCTestCase {
	
	var recentSearchesManager: RecentSearchesManager!
	var recentSearches: [RealmRecentSearchDataModel]!
    
    override func setUp() {
		
		super.setUp()
		
		Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
		recentSearchesManager = RecentSearchesManager()
    }
    
    override func tearDown() {
		
		recentSearchesManager = nil
        super.tearDown()
    }
	
	// MARK: - fetchRecentSearches
	
	func testFetchRecentSearches_RetrievesRecentSearchesInDescendingOrderOfDateAdded() {
		
		addRecentSearchesToRealmDataStore()
		
		let retrievedItems = recentSearchesManager.fetchRecentSearches()
		XCTAssertEqual(retrievedItems, [RecentSearchViewModel(searchTerm: "Test 5"), RecentSearchViewModel(searchTerm: "Test 4"), RecentSearchViewModel(searchTerm: "Test 3"), RecentSearchViewModel(searchTerm: "Test 2"), RecentSearchViewModel(searchTerm: "Test 1")])
	}
	
	// MARK: - helpers
	
	func addRecentSearchesToRealmDataStore() {
		
		let searchTerms = ["Test 1", "Test 2", "Test 3", "Test 4", "Test 5"]
		
		for searchTerm in searchTerms {
			recentSearchesManager.addRecentSearch(withSearchterm: searchTerm)
		}
	}
}
