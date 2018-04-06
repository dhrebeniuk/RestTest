//
//  FeedInteractorInput.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

protocol FeedInteractorInput {
	func load(completion: @escaping JSONResultCompletion<[JSONPost]>)
}
