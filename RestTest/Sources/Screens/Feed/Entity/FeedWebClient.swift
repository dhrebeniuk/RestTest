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

	public func requestPosts(completion: @escaping JSONResultCompletion<[JSONPost]>) {
		let eventsURL = self.webAPIURL.appendingPathComponent("posts")

		Alamofire.request(eventsURL, method: .get, parameters: [:]).responseJSON { (response) in
			switch response.result {
			case .success(_):
				response.data.map { jsonData in
					let decoder = JSONDecoder()
					do {
						let posts = try decoder.decode([JSONPost].self, from: jsonData)
						completion(JSONResult<[JSONPost]>.success(posts))
					}
					catch {
						completion(JSONResult<[JSONPost]>.error(error))
					}
				}
			case .failure(let error):
				completion(JSONResult<[JSONPost]>.error(error))
			}
		}
	}
}
