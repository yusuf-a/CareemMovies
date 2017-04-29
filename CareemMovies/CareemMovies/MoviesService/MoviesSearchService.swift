//
//  MoviesSearchService.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 27/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

protocol MoviesServiceInterface {

	func search(forMovie movie: String, successCallback: @escaping MoviesSearchSuccessBlock, errorCallback: @escaping ErrorCallback) throws
}

class MoviesSearchService: MoviesServiceInterface {
	
	let moviesSearchHTTPRequestFactory: MovieSearchHTTPRequestFactory
	let httpService: HTTPService
	
    init(moviesSearchHTTPRequestFactory: MovieSearchHTTPRequestFactory = MovieSearchHTTPRequestFactory(urlRequestFactory: DefaultURLRequestFactory()), httpService: HTTPService = HTTPService()) {
		
		self.moviesSearchHTTPRequestFactory = moviesSearchHTTPRequestFactory
		self.httpService = httpService
	}
	
	func search(forMovie movie: String, successCallback: @escaping MoviesSearchSuccessBlock, errorCallback: @escaping ErrorCallback) throws {
		
		let httpRequest = try moviesSearchHTTPRequestFactory.search(forMovie: movie)
		
		let _ = httpService.performDataTask(with: httpRequest, successCallback: { (json) in
			
			if let json = json, let movies = Movies(json: json) {
				
				let viewModels = self.convertMoviesToViewModels(movies: movies)
				
				successCallback(viewModels)
			}
			
		}) { (errorInt, dict, error) in
			
			errorCallback(error)
		}
	}
	
	private func convertMoviesToViewModels(movies: Movies) -> [MovieViewModel] {
		
		var movieViewModels = [MovieViewModel]()
		
		movies.results?.forEach {
			
			var formattedImageURL: String?
			
			if let imageURL = $0.posterPath {
				
				formattedImageURL = "http://image.tmdb.org/t/p/w185/\(imageURL)"
			}
			
			let movieViewModel = MovieViewModel(imageUrl: formattedImageURL, title: $0.title, overview: $0.overview, releaseDate: $0.releaseDate?.formattedDateString())
			movieViewModels.append(movieViewModel)
		}
		
		return movieViewModels
	}
}
