//
//  Movies.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 25/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Gloss

struct Movies: Decodable {
	
	let results: [Movie]?
	
	init?(json: JSON) {
		
		self.results = "results" <~~ json
	}
}
