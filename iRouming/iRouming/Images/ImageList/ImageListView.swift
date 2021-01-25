//
//  ImageListView.swift
//  iRouming
//
//  Created by Lope on 21/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ImageListView: View {

	@ObservedObject var interactor = ImageList()

	@State private var selectedImage: RoumingImage? = nil

	var body: some View {
		Group {
			if interactor.isLoading {
				//TODO: missing design
				Text("Loading")
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.background(Color.white)
			} else {
				ScrollView {
					LazyVStack {
						ForEach(interactor.images) { image in
							ImageListCell(image: image)
								.onTapGesture {
									selectedImage = image
								}.padding(.bottom, 12)
						}
					}
				}
				.background(Color(UIColor(hex: 0xEEEEEE)))
			}
		}
		.onAppear {
			if interactor.images.isEmpty && !interactor.isLoading {
				interactor.getImages()
			}
		}
		.navigationBarTitle(Text("Rouming"), displayMode: .inline)
		.fullScreenCover(item: $selectedImage, content: {
			ImageDetailView(image: $0)
		})
	}

}

#if DEBUG
extension View {
	func Print(_ vars: Any...) -> some View {
		for v in vars { print(v) }
		return EmptyView()
	}
}
#endif

extension ImageListView {

	fileprivate init(images: [RoumingImage]) {
		interactor.images = images
	}

}

struct ImageListView_Previews: PreviewProvider {
	static var previews: some View {
		ImageListView(images: [RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140)])
	}
}
