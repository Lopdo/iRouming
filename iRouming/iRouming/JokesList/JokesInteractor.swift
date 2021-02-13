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

	func getJokes() {
		isLoading = true
		currentPage = 0

		dataManager.loadJokes(page: currentPage) { jokes in
			DispatchQueue.main.async {
				self.jokes = jokes
				self.isLoading = false
			}
		}
	}

	func loadNextPage() {
		if isLoading {
			return
		}

		isLoading = true
		currentPage += 1

		dataManager.loadJokes(page: currentPage) { newJokes in
			DispatchQueue.main.async {
				self.jokes = self.jokes + newJokes
				self.isLoading = false
			}
		}
	}
}
