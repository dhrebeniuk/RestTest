//
//  FeedInteractor.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import CoreData

class FeedInteractor: FeedInteractorInput {

	private var webClient: FeedWebClient?
	private var managedContext: NSManagedObjectContext?
	init(webClient: FeedWebClient?, managedContext: NSManagedObjectContext?) {
		self.webClient = webClient
		self.managedContext = managedContext
	}
	
	func load(completion: @escaping (NSFetchedResultsController<Post>, Error?) -> ()) {
		self.webClient?.requestPosts() { [weak self] in
			switch $0 {
			case .success(let posts):
				self?.fetch(posts: posts)
				DispatchQueue.main.async {
					try? self?.managedContext?.save()
					
					self?.createFetchResultController().map() {
						completion($0, nil)
					}
				}
			case .error(let error):
				DispatchQueue.main.async {
					self?.createFetchResultController().map() {
						completion($0, error)
					}
				}
			}
		}
	}
	
	func load(completion: @escaping RequestResultCompletion<NSFetchedResultsController<Post>>) {

	}
	
	private func fetch(posts: [JSONPost]) {
		
		let privateManagedContext = self.managedContext.map() { managedContext -> NSManagedObjectContext in
			let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
			context.parent = managedContext
			return context
		}
		
		Post.entity().name.map() { entityName in
			let fetchRequest = NSFetchRequest<Post>(entityName: entityName)
			(fetchRequest as? NSFetchRequest<NSFetchRequestResult>).map() {
				let deleteRequest = NSBatchDeleteRequest(fetchRequest: $0)
				privateManagedContext.map() {
					_ = try? $0.persistentStoreCoordinator?.execute(deleteRequest, with: $0)
				}
			}
			
			for jsonPost in posts {
				privateManagedContext.map() {
					let post = NSEntityDescription.insertNewObject(forEntityName: entityName, into: $0) as? Post
					post?.title = jsonPost.title
					post?.body = jsonPost.body
					post?.postId = Int64(jsonPost.id)
					post?.userId = Int64(jsonPost.userId)
				}
			}
		}
		
		try? privateManagedContext?.save()
	}
	
	private func createFetchResultController() -> NSFetchedResultsController<Post>? {
		let fetchedResultsController = self.managedContext?.fetchResultsController(entityName: Post.entity().name ?? "", sortDescriptors: []) as? NSFetchedResultsController<Post>
		
		return fetchedResultsController
	}

}
