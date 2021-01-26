//
//  GifsInteractor.swift
//  iRouming
//
//  Created by Lope on 24/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

class GifsInteractor: ObservableObject {

	@Published var gifs: [Gif] = []

	@Published var isLoading = false


	private var dataManager = GifsDataManager()

	func getGifs() {
		isLoading = true

		dataManager.loadGifs { gifs in
			// TODO: fix bg thread, remove Published from gifs?
			self.isLoading = false
			self.gifs = gifs
		}
	}

}
