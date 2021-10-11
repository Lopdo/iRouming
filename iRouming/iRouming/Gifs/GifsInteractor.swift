//
//  GifsInteractor.swift
//  iRouming
//
//  Created by Lope on 24/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

@MainActor
class GifsInteractor: ObservableObject {

	var gifs: [Gif] = []

	@Published var isLoading = false

	private var dataManager = GifsDataManager()

	init() {
		Task {
			isLoading = true
			await getGifs()
			isLoading = false
		}
	}

	func getGifs() async {
		isLoading = true
		gifs = await dataManager.loadGifs()
		isLoading = false
	}

}
