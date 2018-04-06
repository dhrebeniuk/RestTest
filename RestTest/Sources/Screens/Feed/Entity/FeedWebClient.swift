//
//  FeedWebClient.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import Alamofire

class FeedWebClient: WebClient {

	public func requestPosts(completion: @escaping RequestResultCompletion<[JSONPost]>) {
		let postsURL = self.webAPIURL.appendingPathComponent("posts")

		Alamofire.request(postsURL, method: .get, parameters: [:]).responseJSON { (response) in
			switch response.result {
			case .success(_):
				response.data.map { jsonData in
					let decoder = JSONDecoder()
					do {
						let posts = try decoder.decode([JSONPost].self, from: jsonData)
						completion(RequestResult<[JSONPost]>.success(posts))
					}
					catch {
						completion(RequestResult<[JSONPost]>.error(error))
					}
				}
			case .failure(let error):
				completion(RequestResult<[JSONPost]>.error(error))
			}
		}
	}
}
