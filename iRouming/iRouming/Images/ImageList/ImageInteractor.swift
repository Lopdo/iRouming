//
//  ImageInteractor.swift
//  iRouming
//
//  Created by Lope on 21/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import Combine

@MainActor
class ImageInteractor: ObservableObject {

	private var dataManager = ImagesDataManager()

	var images: [RoumingImage] = []
	var imageTriplets: [RoumingImageTriplet] {
		get {
			return stride(from: 0, to: images.count, by: 3).map {
				RoumingImageTriplet(from: Array(images[$0 ..< min($0 + 3, images.count)]))
			}
		}
	}
	@Published var isLoading = false

	/*@Published var refreshing: Bool = false {
		didSet {
			if oldValue == false && refreshing == true {
				refresh()
			}
		}
	}*/

	init() {
		Task {
			isLoading = true
			images = await dataManager.loadImages()
			isLoading = false
		}
	}

	func getImages() async {
		isLoading = true
		images = await dataManager.loadImages()
		isLoading = false
	}

	/*func refresh() async {
		//print("start refresh")
		//isLoading = true
		images = await dataManager.loadImages()
		refreshing = false
	}*/
}
