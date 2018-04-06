//
//  DataSourceFetchResultsAdapter.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import CoreData

class DataSourceFetchResultsAdapter<C: UITableViewCell, M: NSManagedObject>: NSObject, UITableViewDataSource {

	let cellIdentifier:String
	let fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>
	let configureCellHandler: (_ cell: C, _ managedObject: M) -> Void
	
	init(identifier cellIdentifier: String, fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>, handler configureCellHandler: @escaping (_ cell: C, _ managedObject: M) -> Void) {
		
		self.cellIdentifier = cellIdentifier
		self.fetchedResultsController = fetchedResultsController
		self.configureCellHandler = configureCellHandler
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let sections = self.fetchedResultsController.sections {
			return  sections[section].numberOfObjects
		}
		
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)

		(cell as? C).map() { cell in
			let managedObject = self.fetchedResultsController.object(at: indexPath)
			(managedObject as? M).map() { managedObject in
				self.configureCellHandler(cell, managedObject)
			}
		}
		
		return cell
	}
	
	func object(at indexPath: IndexPath) -> M? {
		return self.fetchedResultsController.object(at: indexPath) as? M
	}
	
}
