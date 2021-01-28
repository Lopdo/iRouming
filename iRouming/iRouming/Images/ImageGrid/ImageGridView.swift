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

	@State private var isDone = false

	var body: some View {
		Group {
			if imageList.isLoading {
				//TODO: missing design
				Text("Loading")
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.background(Color.white)
			} else {
				ScrollView {
					/*RefreshableList(data: RefreshData(isDone: $isDone)) {
						imageList.refreshing = true
					} content: {
*/
						let columns = [GridItem(spacing: 3), GridItem(spacing: 3), GridItem(spacing: 3)]
						LazyVGrid(columns: columns, spacing: 3) {
							ForEach(imageList.images) { image in
								ImageGridCell(image: image)
							}
						}.padding(.top, 8)

					//}
				}
				.background(Color(UIColor(hex: 0xEEEEEE)))
			}
		}
		.onAppear {
			if imageList.images.isEmpty && !imageList.isLoading {
				imageList.getImages()
			}
		}
		.navigationBarTitle(Text("Rouming"), displayMode: .inline)

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
