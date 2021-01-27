//
//  CommentsInteractor.swift
//  iRouming
//
//  Created by Lope on 26/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI
import Combine

class CommentsInteractor: ObservableObject {

	private var dataManager = CommentsDataManager()

	var comments: [Comment] = []

	@Published var isLoading = false

	func getComments(for objectId: Int) {
		isLoading = true

		dataManager.loadComments(objectId: objectId) { comments in
			DispatchQueue.main.async {
				self.comments = comments
				self.isLoading = false
			}
		}
	}

}
