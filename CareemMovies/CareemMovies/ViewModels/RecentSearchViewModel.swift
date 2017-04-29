//
//  RecentSearchViewModel.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 29/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

struct RecentSearchViewModel {
	
	let searchTerm: String
}

extension RecentSearchViewModel: Equatable {
	
	static func == (lhs: RecentSearchViewModel, rhs: RecentSearchViewModel) -> Bool {
		
		return lhs.searchTerm == rhs.searchTerm
	}
}
