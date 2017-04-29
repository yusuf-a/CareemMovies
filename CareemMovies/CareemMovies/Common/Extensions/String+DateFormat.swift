//
//  String+DateFormat.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 27/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import Foundation

extension String {
	
	func formattedDateString() -> String? {
		
		let inputFormatter = DateFormatter()
		inputFormatter.dateFormat = "yyyy-MM-dd"
		
		if let date = inputFormatter.date(from: self) {
			
			let outputFormatter = DateFormatter()
			outputFormatter.dateStyle = DateFormatter.Style.long
			
			return outputFormatter.string(from: date)
		}
		
		return nil
	}
}
