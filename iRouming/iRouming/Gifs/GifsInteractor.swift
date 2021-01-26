//
//  GifsInteractor.swift
//  iRouming
//
//  Created by Lope on 24/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

class GifsInteractor: ObservableObject {

	var gifs: [Gif] = []

	@Published var isLoading = false


	private var dataManager = GifsDataManager()

	func getGifs() {
		isLoading = true

		dataManager.loadGifs { gifs in
			DispatchQueue.main.async {
				self.gifs = gifs
				self.isLoading = false
			}
		}
	}

}
