//
//  PostDetailsInteractorInput.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

protocol PostDetailsInteractorInput {
	
	func load(post: JSONPost, completion: @escaping JSONResultCompletion<JSONPostDetails>)

}
