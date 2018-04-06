//
//  PostDetailsAssembly.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import CoreData

class PostDetailsAssembly: Assembly {

	func assembly(in container:  Swinject.Container) {

		container.register(PostDetailsRouter.self) { resolver in
			return PostDetailsRouter()
		}.inObjectScope(.container)
		
		container.register(PostDetailsWebClient.self) { resolver in
			return PostDetailsWebClient()
		}
		
		container.register(PostDetailsInteractor.self) { resolver in
			let webClient = resolver.resolve(PostDetailsWebClient.self)
			let managedContext = resolver.resolve(NSManagedObjectContext.self)
			return PostDetailsInteractor(webClient: webClient, managedContext: managedContext)
		}
		
		container.register(PostDetailsPresenter.self) { resolver in
			let interactor = resolver.resolve(PostDetailsInteractor.self)
			let router = resolver.resolve(PostDetailsRouter.self)
			return PostDetailsPresenter(interactor: interactor, router: router)
		}

		container.storyboardInitCompleted(PostDetailsViewController.self) { resolver, controller in
			let router = resolver.resolve(PostDetailsRouter.self)
			router?.view = controller
			let presenter = resolver.resolve(PostDetailsPresenter.self)
			presenter?.view = controller
			controller.presenter = presenter
		}
	}
}
