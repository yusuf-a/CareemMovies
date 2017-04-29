//
//  MovieListViewController.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 28/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import UIKit

class MovieListViewController: UITableViewController {

    var movieViewModels = [MovieViewModel]()
    var movieSearchService: MoviesSearchService?

    var searchController: UISearchController?

    override func viewDidLoad() {

        super.viewDidLoad()
		
		setUpSearchController()
		setUpTableView()
		getMovies_Test()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movieViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MovieTableViewCell else {
			
			fatalError("MovieTableViewCell in storyboard configured incorrectly")
		}

        cell.configure(with: movieViewModels[indexPath.row])
        cell.layoutIfNeeded()

        return cell
    }
	
	// MARK: - private helpers
	
	private func setUpSearchController() {
		
		searchController = UISearchController(searchResultsController: RecentSearchesTableViewController())
		searchController?.searchBar.sizeToFit()
		tableView.tableHeaderView = searchController?.searchBar
		searchController?.delegate = self
		definesPresentationContext = true
	}
	
	private func setUpTableView() {
		
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 100
	}
	
	private func getMovies_Test() {
		
		movieSearchService = MoviesSearchService()
		try! movieSearchService?.search(forMovie: "batman", successCallback: { (viewmodels) in
			
			self.movieViewModels = viewmodels
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}, errorCallback: { (error) in
			
			print(error.localizedDescription)
		})
	}
}

extension MovieListViewController: UISearchControllerDelegate {
	
	func didPresentSearchController(_ searchController: UISearchController) {
		
		searchController.searchResultsController?.view.isHidden = false
	}
}
