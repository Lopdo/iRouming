//
//  VideosInteractor.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

class VideosInteractor: ObservableObject {

	var videos: [Video] = []

	@Published var isLoading = false


	private var dataManager = VideosDataManager()

	@MainActor
	func getVideos() async {
		isLoading = true

		videos = await dataManager.loadVideos()
		isLoading = false
	}
}
