//
//  String+DateFormat.swift
//  CareemMovies
//
//  Created by Yusuf Afghan on 27/04/2017.
//  Copyright © 2017 Yusuf. All rights reserved.
//

import XCTest

@testable import CareemMovies

class StringDateFormatTests: XCTestCase {
	
	func test_formattedDateString_FormatsDateCorrectly() {
		
		let inputString = "1989-06-23"
		
		XCTAssertEqual(inputString.formattedDateString(), "June 23, 1989")
	}
}
