//
//  JokesInteractor.swift
//  iRouming
//
//  Created by Lope on 12/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import Combine

class JokesInteractor: ObservableObject {

	var jokes: [Joke] = []

	@Published var isLoading = false

	private var dataManager = JokesDataManager()

	private var currentPage = 0

	@MainActor
	func getJokes() async {
		isLoading = true
		currentPage = 0

		jokes = await dataManager.loadJokes(page: currentPage)
		isLoading = false
	}

	@MainActor
	func loadNextPage() async {
		if isLoading {
			return
		}

		isLoading = true
		currentPage += 1

		let newJokes = await dataManager.loadJokes(page: currentPage)
		jokes.append(contentsOf: newJokes)
		isLoading = false
	}
}
