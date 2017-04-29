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
		getMovies_Test(movie: "batman")
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
		searchController?.searchBar.delegate = self
		searchController?.delegate = self
		searchController?.searchResultsUpdater = self
		definesPresentationContext = true
	}
	
	private func setUpTableView() {
		
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 100
	}
	
	internal func getMovies_Test(movie: String) {
		
		movieSearchService = MoviesSearchService()
		try! movieSearchService?.search(forMovie: movie, successCallback: { (viewmodels) in
			
			self.movieViewModels = viewmodels
			
			DispatchQueue.main.async {
				
				self.updateViews()
			}
		}, errorCallback: { (error) in
			
			self.showAlertView(withTitle: "Uh oh! An error occurred", message: "Please try again later")
		})
	}
	
	private func updateViews() {
		
		tableView.reloadData()
		
		if movieViewModels.isEmpty {
			
			showAlertView(withTitle: "Uh oh! No results", message: "Please search again with a different movie")
		}
	}
	
	private func showAlertView(withTitle title: String, message: String) {
		
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alertController.addAction(action)
		
		present(alertController, animated: true, completion: nil)
	}
}

extension MovieListViewController: UISearchControllerDelegate {
	
	func didPresentSearchController(_ searchController: UISearchController) {
		
		searchController.searchResultsController?.view.isHidden = false
	}
}

extension MovieListViewController: UISearchBarDelegate {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		searchController?.searchResultsController?.dismiss(animated: true, completion: nil)
		
		if let searchTerm = searchBar.text {

			getMovies_Test(movie: searchTerm)
		}
	}
}

extension MovieListViewController: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		
		guard let searchBarText = searchController.searchBar.text else {
			
			return
		}
		
		if searchBarText.isEmpty {
			
			searchController.searchResultsController?.view.isHidden = false
		}
	}
}
