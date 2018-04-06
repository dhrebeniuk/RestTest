//
//  PostDetailsWebClient.swift
//  RestTest
//
//  Created by Dmytro Hrebeniuk on 4/6/18.
//  Copyright © 2018 Dmytro. All rights reserved.
//

import Foundation
import Alamofire

class PostDetailsWebClient: WebClient {

	public func requestPostDetails(post: JSONPost, completion: @escaping JSONResultCompletion<JSONPostDetails>) {
		let postDetailsURL = self.webAPIURL.appendingPathComponent("posts").appendingPathComponent("\(post.id)")
		
		Alamofire.request(postDetailsURL, method: .get, parameters: [:]).responseJSON { (response) in
			switch response.result {
			case .success(_):
				response.data.map { jsonData in
					let decoder = JSONDecoder()
					do {
						let posts = try decoder.decode(JSONPostDetails.self, from: jsonData)
						completion(JSONResult<JSONPostDetails>.success(posts))
					}
					catch {
						completion(JSONResult<JSONPostDetails>.error(error))
					}
				}
			case .failure(let error):
				completion(JSONResult<JSONPostDetails>.error(error))
			}
		}
	}
}
