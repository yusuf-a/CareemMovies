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

    override func viewDidLoad() {

        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        super.tableView(tableView, cellForRowAt: indexPath)

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.textLabel!.text = "HEHEHEHE"
        cell.backgroundColor = .red

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        super.tableView(tableView, numberOfRowsInSection: section)

        return 5
    }
}
