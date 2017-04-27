//
//  MovieTableViewCell.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 28/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
	
	@IBOutlet weak var posterImageView: UIImageView!
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var overviewLabel: UILabel!
	@IBOutlet weak var releaseDateLabel: UILabel!
	
	func configure(with viewModel: MovieViewModel) {
		
		title.text = viewModel.title
		overviewLabel.text = viewModel.overview
		releaseDateLabel.text = viewModel.releaseDate
		
		
	}
}
