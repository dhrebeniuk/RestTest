//
//  FeedViewController.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController {
	
	var presenter: FeedPresenterInput?
	var dataSourceAdapter: DataSourceAdapter<FeedCell, JSONPost>?
	
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
		self.presenter?.load() { [weak self] posts in
			guard let `self` = self else { return }
			
			self.dataSourceAdapter = DataSourceAdapter<FeedCell, JSONPost>(identifier: FeedViewController.feedCellIdentifier, objects: posts, handler: { (cell, post) in
			
				cell.postTitleLabel?.text = post.title
				cell.postBodyLabel?.text = post.body
			})
			
			self.tableView.dataSource = self.dataSourceAdapter
			self.tableView.reloadData()
			
			self.unblockUI()
		}
	}
	
	// MARK: - UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.dataSourceAdapter.map() {
			let objects = $0.objects
			if (objects.count > indexPath.row) {
				let post = objects[indexPath.row]
				self.presenter?.show(details: post)
			}
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

