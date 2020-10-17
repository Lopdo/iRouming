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

	var didChange = PassthroughSubject<Void, Never>()

	private var dataManager = ForumDataManager()

	var posts: [ForumPost] = [] {
		didSet {
			didChange.send(())
		}
	}

	var isLoading = false

	private var currentPage = 0

	func getLatestPosts() {
		isLoading = true
		currentPage = 0

		dataManager.loadPosts(page: currentPage) { posts in
			self.isLoading = false
			self.posts = posts
		}
	}

	func loadNextPage() {
		if isLoading {
			return
		}

		isLoading = true
		currentPage += 1

		dataManager.loadPosts(page: currentPage) { newPosts in
			self.isLoading = false
			self.posts = self.posts + newPosts
		}
	}

	
}
