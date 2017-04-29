//
//  RecentSearchesTableViewControllerTests.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 29/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import XCTest

@testable import CareemMovies

class RecentSearchesTableViewControllerTests: XCTestCase {
	
	class MockUIViewController: UIViewController,RecentSearchesTableViewControllerDelegate {
		
		var searchTermSelected = ""
		
		func didSelectSearchTerm(_ searchTerm: String) {
			
			searchTermSelected = searchTerm
		}
	}
	
	var recentSearchesTableViewController: RecentSearchesTableViewController!
	var mockRecentSearchesManager: MockRecentSearchManager!
	var mockViewController: MockUIViewController!
	
	override func setUp() {
		super.setUp()
		mockRecentSearchesManager = MockRecentSearchManager()
		recentSearchesTableViewController = RecentSearchesTableViewController()
		
		mockViewController = MockUIViewController()
		recentSearchesTableViewController.delegate = mockViewController
		
		recentSearchesTableViewController.recentSearchesManager = mockRecentSearchesManager
	}
	
	override func tearDown() {
		
		recentSearchesTableViewController = nil
		super.tearDown()
	}
	
	func test_viewDidAppear_callsFetchRecentSearches() {
		
		recentSearchesTableViewController.viewDidAppear(false)
		
		XCTAssert(mockRecentSearchesManager.fetchRecentSearchesWasCalled)
	}
	
	// MARK: - cellForRow
	
	func testCellForRowAt_setsCellDetailsCorrectly() {
		
		let viewModels = [RecentSearchViewModel(searchTerm: "Batman")]
		
		recentSearchesTableViewController.recentSearches = viewModels
		
		let cell = recentSearchesTableViewController.tableView(recentSearchesTableViewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0))
		
		XCTAssertEqual(cell.textLabel!.text, "Batman")
	}
	
	// MARK: - didSelectRow
	
	func test_didSelectRow_callsDelegate() {
		
		let viewModels = [RecentSearchViewModel(searchTerm: "Batman")]
		
		recentSearchesTableViewController.recentSearches = viewModels
		
		recentSearchesTableViewController.tableView(recentSearchesTableViewController.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
		
		XCTAssertEqual(mockViewController.searchTermSelected, "Batman")
	}
}
