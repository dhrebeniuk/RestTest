//
//  View.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import SegueWithCompletion

protocol View: class {
	
	func perform<T>(segue identifier: String, prepare prepareHandler: ((T) -> ())?)
	
	func performWithNavigationController<T>(segue identifier: String, prepare prepareHandler: ((T) -> ())?)
	
	func show(error: Error?)
}
