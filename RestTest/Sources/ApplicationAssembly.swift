//
//  ApplicationAssembly.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

class ApplicationAssembly {
	
	let container = Container()
	
	func setup() {
		Container.loggingFunction = nil

		container.register(WebClient.self) { _ in
			return WebClient()
		}.inObjectScope(.container)

		self.registerAssemblies(in: self.container)
	}
	
	
	private func registerAssemblies(in container: Swinject.Container) {
		let feedAssembly = FeedAssembly()
		feedAssembly.assembly(in: container)
	}
	
}
