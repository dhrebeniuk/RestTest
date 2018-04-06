//
//  WebClient.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation

public enum RequestResult<T> {
	case success(T)
	case error(Error)
	
	public var success: Bool {
		switch self {
		case .success:
			return true
		case .error:
			return false
		}
	}
}

public typealias RequestResultCompletion<T> = (_ result: RequestResult<T>) -> ()

open class WebClient {

	var webAPIURL: URL { get {
			return URL(string: "https://jsonplaceholder.typicode.com")!
		}
	}

}
