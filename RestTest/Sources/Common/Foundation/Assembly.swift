//
//  Assembly.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Swinject

protocol Assembly {
	func assembly(in container:  Swinject.Container)
}

