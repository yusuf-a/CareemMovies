//
//  RecentSearchesTableViewController.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 28/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import UIKit

protocol RecentSearchesTableViewControllerDelegate {

    func didSelectSearchTerm(_ searchTerm: String)
}

class RecentSearchesTableViewController: UITableViewController {

    var delegate: RecentSearchesTableViewControllerDelegate?
	let recentSearchesManager = RecentSearchesManager()
	var recentSearches = [RecentSearchViewModel]()

	override func viewDidAppear(_ animated: Bool) {
		
		super.viewDidAppear(animated)
		
		recentSearches = recentSearchesManager.fetchRecentSearches()
		tableView.reloadData()
	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        super.tableView(tableView, cellForRowAt: indexPath)

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.textLabel!.text = recentSearches[indexPath.row].searchTerm

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        super.tableView(tableView, numberOfRowsInSection: section)

        return recentSearches.count
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		let recentSearch = recentSearches[indexPath.row]
		
		delegate?.didSelectSearchTerm(recentSearch.searchTerm)
		
		dismiss(animated: true, completion: nil)
	}
}
