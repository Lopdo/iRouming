//
//  CommentsView+ViewModel.swift
//  iRouming
//
//  Created by Lope on 26/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI
import Combine

extension CommentsView {

	@MainActor
	class ViewModel: ObservableObject {

		private var dataManager = CommentsDataManager()

		var comments: [Comment] = []

		@Published var isLoading = false

		func getComments(for objectId: Int) async {
			isLoading = true

			comments = await dataManager.loadComments(objectId: objectId)
			isLoading = false
		}

	}

}
