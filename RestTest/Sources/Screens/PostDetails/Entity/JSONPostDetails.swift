//
//  JSONPostDetails.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

struct JSONPostDetails: Decodable {	
	public let userId: Int
	public let id: Int
	public let title: String
	public let body: String
}
