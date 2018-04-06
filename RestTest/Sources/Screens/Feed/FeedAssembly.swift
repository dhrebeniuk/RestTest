//
//  FeedAssembly.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

class FeedAssembly: Assembly {
	
	func assembly(in container:  Swinject.Container) {
		
		container.register(FeedWebClient.self) { resolver in
			return FeedWebClient()
		}
		
		container.register(FeedInteractor.self) { resolver in
			let webClient = resolver.resolve(FeedWebClient.self)
			return FeedInteractor(webClient: webClient)
		}
		
		container.register(FeedPresenter.self) { resolver in
			let interactor = resolver.resolve(FeedInteractor.self)
			let router = resolver.resolve(FeedRouter.self)

			return FeedPresenter(interactor: interactor, router: router)
		}
		
		container.register(FeedRouter.self) { resolver in
			return FeedRouter()
		}.inObjectScope(.container)
		
		container.storyboardInitCompleted(FeedViewController.self) { resolver, controller in
			let router = resolver.resolve(FeedRouter.self)!
			router.view = controller
			let presenter = resolver.resolve(FeedPresenter.self)
			presenter?.view = controller
			controller.presenter = presenter
		}
		
	}

}
