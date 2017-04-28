//
//  MovieListViewController.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 28/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import UIKit

class MovieListViewController: UITableViewController, UISearchControllerDelegate {

    var movieViewModels = [MovieViewModel]()
    var movieSearchService: MoviesSearchService?

    var searchController: UISearchController!

    override func viewDidLoad() {

        super.viewDidLoad()

        searchController = UISearchController(searchResultsController: RecentSearchesTableViewController())
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        searchController.delegate = self
        definesPresentationContext = true

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300

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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movieViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //force unwrapped as this would be a developer error
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell

        cell.configure(with: movieViewModels[indexPath.row])

        cell.layoutIfNeeded()

        return cell
    }

    func didPresentSearchController(_ searchController: UISearchController) {

        searchController.searchResultsController?.view.isHidden = false
    }
}
