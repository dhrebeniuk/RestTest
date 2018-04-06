//
//  FeedInteractor.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

class FeedInteractor: FeedInteractorInput {

	private var webClient: FeedWebClient?
	init(webClient: FeedWebClient?) {
		self.webClient = webClient
	}
	
	func load(completion: @escaping JSONResultCompletion<[JSONPost]>) {
		self.webClient?.requestPosts() { result in
			completion(result)
		}
	}
}
