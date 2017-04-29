//
//  Movie.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 25/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Gloss

struct Movie: Decodable {
	
	let posterPath: String?
	let title: String?
	let releaseDate: String?
	let overview: String?
	
	init?(json: JSON) {
		
		self.posterPath = "poster_path" <~~ json
		self.title = "original_title" <~~ json
		self.releaseDate = "release_date" <~~ json
		self.overview = "overview" <~~ json
	}
}
