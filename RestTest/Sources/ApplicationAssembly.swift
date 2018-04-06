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
import CoreData

class ApplicationAssembly {
	
	let container = Container()
	
	func setup() {
		Container.loggingFunction = nil

		container.register(NSManagedObjectContext.self) { _ in
			return ApplicationAssembly.createManagedObjectContenxt()
		}.inObjectScope(.container)

		self.registerAssemblies(in: self.container)
	}
	
	
	private func registerAssemblies(in container: Swinject.Container) {
		let feedAssembly = FeedAssembly()
		feedAssembly.assembly(in: container)
		
		let postDetailsAssembly = PostDetailsAssembly()
		postDetailsAssembly.assembly(in: container)
	}
	
}

extension ApplicationAssembly {
	
	private static func createManagedObjectContenxt() -> NSManagedObjectContext {
		let storageURL = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("PostsDataModel.sqlite")
		
		guard let managedModelURL = Bundle.main.url(forResource: "PostsDataModel", withExtension: "momd") else { fatalError() }
		guard let managedObjectModel = NSManagedObjectModel(contentsOf: managedModelURL) else { fatalError() }
		
		return try! NSManagedObjectContext.managedObjectContext(atURL: storageURL, withModel: managedObjectModel)
	}
	
}

