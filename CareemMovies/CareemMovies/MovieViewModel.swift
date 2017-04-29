
//
//  MovieViewModel.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 27/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

struct MovieViewModel {
	
	let imageUrl: String?
	let title: String?
	let overview: String?
	let releaseDate: String?
}

extension MovieViewModel: Equatable {
	
	static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
		
		return lhs.imageUrl == rhs.imageUrl && lhs.title == rhs.title && lhs.overview == rhs.overview && lhs.releaseDate == rhs.releaseDate
	}
}
