//
//  PostDetailsPresenter.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

class PostDetailsPresenter {

	weak var view: PostDetailsView?

	private var interactor: PostDetailsInteractorInput?
	private var router: PostDetailsRouterInput?
	init(interactor: PostDetailsInteractorInput?, router: PostDetailsRouterInput?) {
		self.interactor = interactor
		self.router = router
	}
}

extension PostDetailsPresenter: PostDetailsPresenterInput {
	
	func load(post: JSONPost, completion: @escaping (JSONPostDetails) -> ()) {
		self.interactor?.load(post: post) { [weak self] in
			switch $0 {
			case .success(let result):
				completion(result)
			case .error(let error):
				self?.router?.show(error: error)
			}
		}
	}
}
