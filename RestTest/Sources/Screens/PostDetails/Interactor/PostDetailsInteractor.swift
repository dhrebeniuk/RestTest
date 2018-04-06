//
//  PostDetailsInteractor.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import CoreData

class PostDetailsInteractor: PostDetailsInteractorInput {

	private var webClient: PostDetailsWebClient?
	private var managedContext: NSManagedObjectContext?
	init(webClient: PostDetailsWebClient?, managedContext: NSManagedObjectContext?) {
		self.webClient = webClient
		self.managedContext = managedContext
	}
	
	func load(post: Post, completion: @escaping RequestResultCompletion<Post>) {
		let postId = Int(post.postId)
		self.webClient?.requestPostDetails(postId: postId) {
			switch $0 {
			case .success(let result):
				self.fetch(jsonPostDetails: result, completion: completion)
			case .error(let error):
				completion(RequestResult<Post>.error(error))
			}
		}
	}

	private func fetch(jsonPostDetails: JSONPostDetails, completion: @escaping RequestResultCompletion<Post>) {
		DispatchQueue.main.async {
			Post.entity().name.map() {
				var post: Post? = nil
				do {
					post = try self.managedContext?.fetchManagedObject(entityName: $0,
							uniqueItems: [(key: #keyPath(Post.postId), value: NSNumber(value: jsonPostDetails.id))]) as? Post
						post?.title = jsonPostDetails.title
						post?.body = jsonPostDetails.body
					
					try self.managedContext?.save()
				}
				catch {
					
				}
			
				post.map() {
					completion(RequestResult<Post>.success($0))
				}
			}
		}
	}
}
