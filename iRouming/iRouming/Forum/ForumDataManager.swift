//
//  ForumDataManager.swift
//  iRouming
//
//  Created by Lope on 13/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import Foundation

struct ForumDataManager {

	func loadPosts(page: Int) async -> [ForumPost] {

		do {
			let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.rouming.cz/roumingXMLNew.php?action=forum&json=1&page=\(page)")!)
			return try JSONDecoder().decode([ForumPost].self, from: data)
		} catch {
			print(error)
			return []
		}

	}

	func loadThreads(page: Int) async -> [ForumThread] {

		do {
			let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.rouming.cz/roumingXMLNew.php?action=forumThreads&json=1&page=\(page)")!)
			return try JSONDecoder().decode([ForumThread].self, from: data)
		} catch {
			print(error)
			return []
		}

	}

	func loadPosts(for threadId: Int, page: Int) async -> [ForumPost] {

		do {
			let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.rouming.cz/roumingXMLNew.php?json=1&action=forum&thread=\(threadId)")!)
			return try JSONDecoder().decode([ForumPost].self, from: data)
		} catch {
			print(error)
			return []
		}

	}
}
