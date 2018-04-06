//
//  FeedPresenter.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import CoreData

class FeedPresenter {

	weak var view: FeedView?

	private var interactor: FeedInteractorInput?
	private var router: FeedRouterInput?
	
	init(interactor: FeedInteractorInput?, router: FeedRouterInput?) {
		self.interactor = interactor
		self.router = router
	}
	
}

extension FeedPresenter: FeedPresenterInput {
	
	func load(completion: @escaping (NSFetchedResultsController<Post>) -> ()) {
		self.interactor?.load() { [weak self] (fetchResults, error) in
			completion(fetchResults)
			
			error.map() {
				self?.router?.show(error: $0)
			}
		}
	}
	
	func show(details post: Post) {
		self.router?.show(details: post)
	}

}
