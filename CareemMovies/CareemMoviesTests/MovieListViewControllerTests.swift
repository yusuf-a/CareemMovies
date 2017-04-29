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
	
	override func tearDown() {
		
		movieListViewController = nil
		super.tearDown()
	}

    func test_numberOfRowsInSection_ReturnsMovieViewModelCount() {

        XCTAssertEqual(movieListViewController.tableView(movieListViewController.tableView, numberOfRowsInSection: 0), 3)
    }

    func test_cellForRowAtIndexPath_cellIsMovieTableViewCell() {

        let cell = movieListViewController.tableView(movieListViewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0))

        XCTAssert(cell is MovieTableViewCell)
    }
	
	// MARK: - viewDidLoad
	
	func test_viewDidLoad_searchController_resultsViewController_is_RecentSearchesTableViewController() {
		
		movieListViewController.viewDidLoad()
		
		XCTAssert(movieListViewController.searchController?.searchResultsController is RecentSearchesTableViewController)
	}
	
	func test_viewDidLoad_tableHeaderView_is_searchControllerSearchBar() {
		
		movieListViewController.viewDidLoad()
		
		XCTAssertEqual(movieListViewController.tableView.tableHeaderView!, movieListViewController.searchController?.searchBar)
	}
	
	func test_viewDidLoad_searchControllerDelegate_isMovieListViewController() {
		
		movieListViewController.viewDidLoad()
		
		XCTAssert(movieListViewController.searchController?.delegate === movieListViewController)
	}
	
	func test_viewDidLoad_movieListViewController_definesPresentationContext_true() {
		
		movieListViewController.viewDidLoad()
		XCTAssertTrue(movieListViewController.definesPresentationContext)
	}
	
	func test_viewDidLoad_tableView_rowHeight_is_UITableViewAutomaticDimension() {
		
		movieListViewController.viewDidLoad()
		XCTAssertEqual(movieListViewController.tableView.rowHeight, UITableViewAutomaticDimension)
	}
	
	func test_viewDidLoad_tableView_rowHeight_estimatedRowHeight_is_100() {
		
		movieListViewController.viewDidLoad()
		XCTAssertEqual(movieListViewController.tableView.estimatedRowHeight, 100)
	}
	
	// MARK: - UISearchControllerDelegate
	
	func test_didPresentSearchController_searchController_viewNotHidden() {
		
		movieListViewController.didPresentSearchController(movieListViewController.searchController!)
		XCTAssertFalse(movieListViewController.searchController!.view.isHidden)
	}
}
