//
//  VideosInteractor.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

@MainActor
class VideosInteractor: ObservableObject {

	var videos: [Video] = []

	@Published var isLoading = false

	private var dataManager = VideosDataManager()

	init() {
		Task {
			isLoading = true
			await getVideos()
			isLoading = false
		}
	}

	func getVideos() async {
		isLoading = true
		videos = await dataManager.loadVideos()
		isLoading = false
	}
}
