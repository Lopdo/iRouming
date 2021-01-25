//
//  ForumInteractor.swift
//  iRouming
//
//  Created by Lope on 13/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import Combine

class ForumInteractor: ObservableObject {

	private var dataManager = ForumDataManager()

	var threads: [ForumThread] = []
	private var allPosts: [ForumPost] = []
	private var postsByThread: [Int: [ForumPost]] = [:]

	@Published var currentThread: ForumThread? {
		didSet {
			if let currentThread = currentThread {
				getPosts(for: currentThread.id)
			}
		}
	}

	@Published var isLoadingThreads = false
	@Published var isLoadingPosts = false

	private var currentPage = 0

	func posts(for threadId: Int?) -> [ForumPost] {
		if let threadId = threadId {
			return postsByThread[threadId] ?? []
		} else {
			return allPosts
		}
	}

	func postsForCurrentThread() -> [ForumPost] {
		if let thread = currentThread {
			return postsByThread[thread.id] ?? []
		} else {
			return allPosts
		}
	}

	func getLatestPosts() {
		isLoadingPosts = true
		currentPage = 0

		dataManager.loadPosts(page: currentPage) { posts in
			DispatchQueue.main.async {
				self.allPosts = posts
				Set(posts.map { $0.threadId }).forEach { threadId in
					self.postsByThread[threadId] = posts.filter { $0.threadId == threadId }
				}
				self.isLoadingPosts = false
			}
		}
	}

	func getPosts(for threadId: Int) {
		isLoadingPosts = true

		dataManager.loadPosts(for: threadId, page: 0) { posts in
			DispatchQueue.main.async {
				self.postsByThread[threadId] = posts
				self.isLoadingPosts = false
			}
		}
	}

	func getThreads() {
		isLoadingThreads = true

		dataManager.loadThreads(page: 0) { threads in
			DispatchQueue.main.async {
				self.threads = threads
				self.isLoadingThreads = false
			}
		}
	}

	/*func loadNextPage() {
		if isLoadingPosts {
			return
		}

		isLoadingPosts = true
		currentPage += 1

		dataManager.loadPosts(page: currentPage) { newPosts in
			self.allPosts = self.allPosts + newPosts
			self.isLoadingPosts = false
		}
	}*/

	
}
