//
//  PostDetailsViewController.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit
import CoreData

class PostDetailsViewController: UITableViewController {

	var post: Post?
	
	var presenter: PostDetailsPresenterInput?
	
	@IBOutlet weak var titleLabel: UILabel?
	@IBOutlet weak var bodyLabel: UILabel?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.loadData()
    }
	
	@IBAction func refreshData(_ sender: Any) {
		self.loadData()
	}
	
	private func loadData() {
		self.post.map() {
			self.presenter?.load(post: $0) { [weak self] postDetails in
				self?.titleLabel?.text = postDetails.title
				self?.bodyLabel?.text = postDetails.body
				
				self?.unblockUI()
			}
		}
	}
}

extension PostDetailsViewController: PostDetailsView {
	
	func unblockUI() {
		self.refreshControl?.endRefreshing()
	}
	
}
