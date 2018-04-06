//
//  FeedViewController.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import CoreData

class FeedViewController: UITableViewController {
	
	var presenter: FeedPresenterInput?
	var dataSourceAdapter: DataSourceFetchResultsAdapter<FeedCell, Post>?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.estimatedRowHeight = self.tableView.rowHeight
		self.tableView.rowHeight = UITableViewAutomaticDimension;
		
		self.refreshControl?.beginRefreshing()
		self.loadData()
	}
	
	@IBAction func refreshData(_ sender: Any) {
		self.loadData()
	}
	
	private func loadData() {
		self.presenter?.load() { [weak self] postsResults in
			guard let `self` = self else { return }
			
			self.dataSourceAdapter = (postsResults as? NSFetchedResultsController<NSFetchRequestResult>).map() { postsResults in
				DataSourceFetchResultsAdapter<FeedCell, Post>(identifier: FeedViewController.feedCellIdentifier, fetchedResultsController: postsResults) { (cell, post) in
					cell.postTitleLabel?.text = post.title
					cell.postBodyLabel?.text = post.body
				}
			}
			
			self.tableView.dataSource = self.dataSourceAdapter
			
			try? postsResults.performFetch()
			
			self.tableView.reloadData()
			
			self.unblockUI()
		}
	}
	
	// MARK: - UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.dataSourceAdapter?.object(at: indexPath).map() {
			self.presenter?.show(details: $0)
		}
	}
}

extension FeedViewController: FeedView {
	func unblockUI() {
		self.refreshControl?.endRefreshing()
	}
}

extension FeedViewController {
	private static let feedCellIdentifier = "feedCell"
}

