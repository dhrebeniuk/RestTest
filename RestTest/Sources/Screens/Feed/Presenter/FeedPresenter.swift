//
//  FeedPresenter.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

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
	
	func load(completion: @escaping ([JSONPost]) -> ()) {
		self.interactor?.load() { [weak self] in
			switch $0 {
			case .success(let result):
				completion(result)
			case .error(let error):
				self?.router?.show(error: error)
			}
		}
	}
}
