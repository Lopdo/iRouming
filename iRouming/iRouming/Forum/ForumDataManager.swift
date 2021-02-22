//
//  ForumDataManager.swift
//  iRouming
//
//  Created by Lope on 13/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import Foundation

struct ForumDataManager {

	func loadPosts(page: Int, success: @escaping ([ForumPost]) -> ()) {

		let task = URLSession.shared.dataTask(with: "https://www.rouming.cz/roumingXMLNew.php?action=forum&json=1&page=\(page)") { (result: Result<[ForumPost], Error>) in
			switch result {
			case .success(let posts):
				success(posts)
			case .failure(let error):
				print(error)
			}
		}

		task.resume()
	}

	func loadThreads(page: Int, success: @escaping ([ForumThread]) -> ()) {

		let task = URLSession.shared.dataTask(with: "https://www.rouming.cz/roumingXMLNew.php?action=forumThreads&json=1&page=\(page)") { (result: Result<[ForumThread], Error>) in
			switch result {
			case .success(let threads):
				success(threads)
			case .failure(let error):
				print(error)
			}
		}

		task.resume()
	}

	func loadPosts(for threadId: Int, page: Int, success: @escaping ([ForumPost]) -> ()) {

		let task = URLSession.shared.dataTask(with: "https://www.rouming.cz/roumingXMLNew.php?json=1&action=forum&thread=\(threadId)") { (result: Result<[ForumPost], Error>) in
			switch result {
			case .success(let posts):
				success(posts)
			case .failure(let error):
				print(error)
			}
		}

		task.resume()
	}
}
