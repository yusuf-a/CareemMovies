//
//  RealmRecentSearches.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 29/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import RealmSwift

class RealmRecentSearchDataModel: RealmSwift.Object {
	
	dynamic var searchTerm: String = ""
	dynamic var dateAdded: Date = Date()
	
	convenience init(searchTerm: String) {
		
		self.init()
		self.searchTerm = searchTerm
	}
	
	override static func primaryKey() -> String? {
		
		return "searchTerm"
	}
}
