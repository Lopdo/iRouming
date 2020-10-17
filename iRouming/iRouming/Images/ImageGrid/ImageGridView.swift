//
//  ImageGridView.swift
//  iRouming
//
//  Created by Lope on 26/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ImageGridView: View {

	@ObservedObject var imageList = ImageList()

	// We are using this property to prevent NavigationLink from applying visual tap
	// effect on the whole image cell
	@State private var isShowingDetailView = false
	@State private var selectedIndex: Int = 0
	//private var selectedIndex: Int?

	@State private var isDone = false

	var body: some View {
		Group {
			if imageList.isLoading {
				//TODO: missing design
				Text("Loading")
			} else {
				ScrollView {
					RefreshableList(data: RefreshData(isDone: $isDone)) {
						imageList.refreshing = true
					} content: {

					//}

					/*RefreshableNavigationView(title: "dsada", action: {
						imageList.refreshing = true
					}, isDone: $imageList.refreshing) {*/

					//}
					//RefreshableScrollView(height: 70, refreshing: $imageList.refreshing) {

						let columns = [GridItem(spacing: 3), GridItem(spacing: 3), GridItem(spacing: 3)]
						LazyVGrid(columns: columns, spacing: 3) {
							ForEach(0..<imageList.images.count) { index in
								ImageGridCell(image: imageList.images[index])
									.onTapGesture {
										//TODO: fix index
										selectedIndex = index
										isShowingDetailView = true
										print("tap2", selectedIndex)
									}
							}
						}.padding(.top, 8)
						

					}
				}
				.background(Color(UIColor(hex: 0xEEEEEE)))

				//.background(Color(UIColor(hex: 0xEEEEEE)))

				/**/
			}
		}
		.onAppear {
			if imageList.images.isEmpty && !imageList.isLoading {
				imageList.getImages()
			}
		}
		.navigationBarTitle(Text("Rouming"), displayMode: .inline)
		.fullScreenCover(isPresented: $isShowingDetailView, content: {
			ImageDetailView(image: imageList.images[selectedIndex])
		})
	}

}

extension ImageGridView {

	fileprivate init(images: [RoumingImage]) {
		imageList.images = images
	}
}

struct ImageGridView_Previews: PreviewProvider {
	static var previews: some View {
		ImageGridView(images: [RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140)])
	}
}
