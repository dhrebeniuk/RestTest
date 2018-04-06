//
//  PostDetailsInteractor.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

class PostDetailsInteractor: PostDetailsInteractorInput {

	private var webClient: PostDetailsWebClient?
	init(webClient: PostDetailsWebClient?) {
		self.webClient = webClient
	}
	
	func load(post: JSONPost, completion: @escaping JSONResultCompletion<JSONPostDetails>) {
		self.webClient?.requestPostDetails(post: post) { result in
			completion(result)
		}
	}

}
