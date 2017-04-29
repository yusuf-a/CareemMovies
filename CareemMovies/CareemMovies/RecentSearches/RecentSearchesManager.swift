//
//  RecentSearchesManager.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 29/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import RealmSwift

class RecentSearchesManager {
	
	private let maxRecentSearches = 10
	
	func fetchRecentSearches() -> [RecentSearchViewModel] {
		
		do {
			let realm = try self.getRealmInstance()
			
			return realm.getSortedRecentSearches().map {
				RecentSearchViewModel(searchTerm: $0.searchTerm)
			}
		} catch {

			// Fail gracefully
			return []
		}
	}
	
	func addRecentSearch(withSearchterm searchTerm: String) {
		do {
			let realm = try self.getRealmInstance()
			try realm.write {
				realm.removeLastRecentSearch(ifCountExceeds: maxRecentSearches - 1)
				let realmRecentSearch = RealmRecentSearchDataModel(searchTerm: searchTerm)
				realm.add(realmRecentSearch, update: true)
			}
		} catch {
			
			return
		}
	}
	
	private func getRealmInstance() throws -> Realm {
		return try Realm(configuration: .defaultConfiguration)
	}
}

extension Realm {
	
	func removeLastRecentSearch(ifCountExceeds maximumCount: Int) {
		
		let currentRecentSearches = getSortedRecentSearches()
		
		guard currentRecentSearches.count > maximumCount else {
			
			return
		}
		
		guard let lastRecentSearch = currentRecentSearches.last else {
			
			return
		}
		
		delete(lastRecentSearch)
	}
	
	func getSortedRecentSearches() -> [RealmRecentSearchDataModel] {
		
		let realmRecentSearches = Array(objects(RealmRecentSearchDataModel.self))
		
		return realmRecentSearches.sorted {
			$0.0.dateAdded.timeIntervalSince1970 > $0.1.dateAdded.timeIntervalSince1970
		}
	}
}
