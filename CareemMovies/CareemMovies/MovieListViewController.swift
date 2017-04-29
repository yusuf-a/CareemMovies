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
    var movieSearchService: MoviesSearchService = MoviesSearchService()

    var searchController: UISearchController?
	
	var currentSearchTerm = ""
	
	var recentSearchesManager = RecentSearchesManager()

    override func viewDidLoad() {

        super.viewDidLoad()
		
		setUpSearchController()
		setUpTableView()
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
		
		let recentSearchesTableViewController = RecentSearchesTableViewController()
		searchController = UISearchController(searchResultsController: recentSearchesTableViewController)
		searchController?.searchBar.sizeToFit()
		tableView.tableHeaderView = searchController?.searchBar
		recentSearchesTableViewController.delegate = self
		searchController?.searchBar.delegate = self
		searchController?.delegate = self
		searchController?.searchResultsUpdater = self
		definesPresentationContext = true
	}
	
	private func setUpTableView() {
		
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 100
		refreshControl?.addTarget(self, action: #selector(refreshView), for: .valueChanged)
	}
	
	@objc private func refreshView() {
		
		refreshControl?.beginRefreshing()
		
		if currentSearchTerm.isEmpty {
			
			refreshControl?.endRefreshing()
			return }
		getMovies(for: currentSearchTerm)
	}
	
	internal func getMovies(for searchTerm: String) {
		
		currentSearchTerm = searchTerm
		
		do {
			
			try movieSearchService.search(forMovie: searchTerm, successCallback: { (viewmodels) in
				
				self.movieViewModels = viewmodels
				
				DispatchQueue.main.async {
					
					self.tableView.reloadData()
					self.handleResults()
					self.refreshControl?.endRefreshing()
				}
			}, errorCallback: { (_) in
				self.showErrorAlert()
			})
			
		} catch {
			
			showErrorAlert()
		}
	}
	
	private func showErrorAlert() {
		
		showAlertView(withTitle: "Uh oh! An error occurred", message: "Please try again later")
	}
	
	private func handleResults() {
		
		tableView.reloadData()
		
		if movieViewModels.isEmpty {
			
			showAlertView(withTitle: "Uh oh! No results", message: "Please search again with a different movie")
		} else {
			
			recentSearchesManager.addRecentSearch(withSearchterm: currentSearchTerm)
		}
	}
	
	private func showAlertView(withTitle title: String, message: String) {
		
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alertController.addAction(action)
		
		present(alertController, animated: true) { 
			self.refreshControl?.endRefreshing()
		}
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

			getMovies(for: searchTerm)
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

extension MovieListViewController: RecentSearchesTableViewControllerDelegate {
	
	func didSelectSearchTerm(_ searchTerm: String) {
		
		getMovies(for: searchTerm)
	}
}
