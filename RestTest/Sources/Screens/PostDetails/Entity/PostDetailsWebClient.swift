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

	public func requestPostDetails(postId: Int, completion: @escaping RequestResultCompletion<JSONPostDetails>) {
		let postDetailsURL = self.webAPIURL.appendingPathComponent("posts").appendingPathComponent("\(postId)")
		
		Alamofire.request(postDetailsURL, method: .get, parameters: [:]).responseJSON { (response) in
			switch response.result {
			case .success(_):
				response.data.map { jsonData in
					let decoder = JSONDecoder()
					do {
						let posts = try decoder.decode(JSONPostDetails.self, from: jsonData)
						completion(RequestResult<JSONPostDetails>.success(posts))
					}
					catch {
						completion(RequestResult<JSONPostDetails>.error(error))
					}
				}
			case .failure(let error):
				completion(RequestResult<JSONPostDetails>.error(error))
			}
		}
	}
}
