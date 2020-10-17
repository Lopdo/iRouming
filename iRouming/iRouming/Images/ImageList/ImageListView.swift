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

	// We are using this property to prevent NavigationLink from applying visual tap
	// effect on the whole image cell
	@State private var isShowingDetailView = false
	@State private var selectedIndex: Int = 0
	//private var selectedIndex: Int?

	var body: some View {
		Group {
			if interactor.isLoading {
				//TODO: missing design
				Text("Loading")
			} else {
				ScrollView {
					LazyVStack {
						ForEach(0..<interactor.images.count) { index in
							ImageListCell(image: interactor.images[index])
								.onTapGesture {
									selectedIndex = index
									isShowingDetailView = true
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
		.fullScreenCover(isPresented: $isShowingDetailView, content: {
			ImageDetailView(image: interactor.images[selectedIndex])
		})
	}

}

extension View {
	func Print(_ vars: Any...) -> some View {
		for v in vars { print(v) }
		return EmptyView()
	}
}

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
