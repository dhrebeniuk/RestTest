//
//  FeedPresenterInput.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import CoreData

protocol FeedPresenterInput {

	func load(completion: @escaping (NSFetchedResultsController<Post>) -> ())
	
	func show(details post: Post)

}
