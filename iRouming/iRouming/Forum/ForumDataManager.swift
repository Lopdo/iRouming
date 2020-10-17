//
//  ForumDataManager.swift
//  iRouming
//
//  Created by Lope on 13/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import Alamofire

struct ForumDataManager {

	func loadPosts(page: Int, success: @escaping ([ForumPost]) -> ()) {

		AF.request("http://www.rouming.cz/roumingXMLNew.php?action=forum&json=1&page=\(page)").responseDecodable { (response: DataResponse<[ForumPost], AFError>)  in
			switch response.result {
			case .success(let posts):
				success(posts)
			case .failure(let error):
				print(error)
			}
		}

	}

	func loadThreads(page: Int, success: @escaping ([ForumThread]) -> ()) {

		AF.request("http://www.rouming.cz/roumingXMLNew.php?json=1&action=forumThreads").responseDecodable { (response: DataResponse<[ForumThread], AFError>)  in
			switch response.result {
			case .success(let threads):
				success(threads)
			case .failure(let error):
				print(error)
			}
		}

	}

	func loadPostsFor(thread: Int, page: Int, success: @escaping ([ForumPost]) -> ()) {

		AF.request("http://www.rouming.cz/roumingXMLNew.php?json=1&action=forum&thread=\(thread)").responseDecodable { (response: DataResponse<[ForumPost], AFError>)  in
			switch response.result {
			case .success(let posts):
				success(posts)
			case .failure(let error):
				print(error)
			}
		}

	}
}
