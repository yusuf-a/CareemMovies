//
//  MockMovieSearchService.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 28/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

@testable import CareemMovies

class MockMoviesSearchService: MoviesSearchService {

    var searchWasCalledWithSearchTerm: String? = nil

    override func search(forMovie movie: String, successCallback: @escaping MoviesSearchSuccessBlock, errorCallback: @escaping ErrorCallback) throws {

        searchWasCalledWithSearchTerm = movie
    }
}
