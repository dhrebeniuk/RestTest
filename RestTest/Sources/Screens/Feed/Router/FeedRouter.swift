//
//  FeedRouter.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import UIKit

class FeedRouter {

	weak var view: FeedView?

}

extension FeedRouter: FeedRouterInput {
	
	func show(error: Error?) {
		self.view?.unblockUI()
		
		self.view?.show(error: error)
	}

}

