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

	private var dataManager = ImagesDataManager()

	var images: [RoumingImage] = []

	@Published var isLoading = false

	/*@Published var refreshing: Bool = false {
		didSet {
			if oldValue == false && refreshing == true {
				refresh()
			}
		}
	}*/

	@MainActor
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
