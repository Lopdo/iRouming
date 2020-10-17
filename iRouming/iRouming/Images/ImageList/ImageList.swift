//
//  ImageList.swift
//  iRouming
//
//  Created by Lope on 21/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import Combine

class ImageList: ObservableObject {

	private var dataManager = ImageListDataManager()

	@Published var images: [RoumingImage] = []

	@Published var isLoading = false

	@Published var refreshing: Bool = false {
		didSet {
			if oldValue == false && refreshing == true {
				refresh()
			}
		}
	}

	func getImages() {
		isLoading = true
		dataManager.loadImages { images in
			self.isLoading = false
			self.images = images
		}

	}

	func refresh() {
		print("start refresh")
		//isLoading = true
		dataManager.loadImages { images in
			print("end refresh")
			//self.isLoading = false
			self.refreshing = false
			self.images = images
		}
	}
}
