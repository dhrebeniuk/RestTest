//
//  PostDetailsPresenterInput.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

protocol PostDetailsPresenterInput {
	
	func load(post: Post, completion: @escaping (Post) -> ())

}
