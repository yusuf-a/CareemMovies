//
//  MovieListViewControllerTests.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 28/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import XCTest

@testable import CareemMovies

class MovieListViewControllerTests: XCTestCase {

    var movieListViewController: MovieListViewController!
    var mockMovieViewModels: [MovieViewModel]!
    var mockService: MockMoviesSearchService!
    
    override func setUp() {
        super.setUp()

        mockService = MockMoviesSearchService(moviesSearchHTTPRequestFactory: MovieSearchHTTPRequestFactory(urlRequestFactory: MockURLRequestFactory()), httpService: MockHTTPService(urlSession: MockUrlSession()))

        movieListViewController = (UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController() as! UINavigationController).viewControllers.first as! MovieListViewController

        movieListViewController.movieSearchService = mockService

        let mockMovieViewModel = MovieViewModel(imageUrl: nil, title: nil, overview: nil, releaseDate: nil)

        mockMovieViewModels = [mockMovieViewModel, mockMovieViewModel, mockMovieViewModel]

        movieListViewController.movieViewModels = mockMovieViewModels

        let _ = movieListViewController.view
    }

    func test_numberOfRowsInSection_ReturnsMovieViewModelCount() {

        XCTAssertEqual(movieListViewController.tableView(movieListViewController.tableView, numberOfRowsInSection: 0), 3)
    }

    func test_cellForRowAtIndexPath_cellIsMovieTableViewCell() {

        let cell = movieListViewController.tableView(movieListViewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0))

        XCTAssert(cell is MovieTableViewCell)
    }
}
