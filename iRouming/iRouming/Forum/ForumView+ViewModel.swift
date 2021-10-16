//
//  ForumView+ViewModel.swift
//  iRouming
//
//  Created by Lope on 13/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import Combine

extension ForumView {

	@MainActor
	class ViewModel: ObservableObject {

		private var dataManager = ForumDataManager()

		var threads: [ForumThread] = []
		private var allPosts: [ForumPost] = []
		private var postsByThread: [Int: [ForumPost]] = [:]

		@Published var currentThread: ForumThread? {
			didSet {
				if let currentThread = currentThread {
					Task {
						await getPosts(for: currentThread.id)
					}
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

		func getLatestPosts() async {
			isLoadingPosts = true
			currentPage = 0

			allPosts = await dataManager.loadPosts(page: currentPage)
			Set(allPosts.map { $0.threadId }).forEach { threadId in
				postsByThread[threadId] = allPosts.filter { $0.threadId == threadId }
			}
			isLoadingPosts = false
		}

		func getPosts(for threadId: Int) async {
			isLoadingPosts = true
			postsByThread[threadId] = await dataManager.loadPosts(for: threadId, page: 0)
			isLoadingPosts = false
		}

		func getThreads() async {
			isLoadingThreads = true
			threads = await dataManager.loadThreads(page: 0)
			isLoadingThreads = false
		}

	}

}
