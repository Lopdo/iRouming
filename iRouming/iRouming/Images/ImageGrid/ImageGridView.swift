//
//  ImageGridView.swift
//  iRouming
//
//  Created by Lope on 26/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI
import Firebase

struct ImageGridView: View {

	@ObservedObject var viewModel: ImagesView.ViewModel

	@State private var isDone = false

	var body: some View {
		Group {
			if viewModel.isLoading && viewModel.images.isEmpty{
				LoadingView()
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			} else {
				List(viewModel.imageTriplets) { triplet in
					HStack(spacing: 3) {
						ImageGridCell(image: triplet.i1)
						if triplet.i2 == nil {
							ImageGridEmptyCell()
						} else {
							ImageGridCell(image: triplet.i2!)
						}
						if triplet.i3 == nil {
							ImageGridEmptyCell()
						} else {
							ImageGridCell(image: triplet.i3!)
						}
					}
					.listRowSeparator(.hidden)
					.listRowInsets(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
					.listRowBackground(Color.background)
				}
				.listStyle(.plain)
				.background(Color.background)
				.refreshable {
					await viewModel.getImages()
				}
			}
		}
		.onAppear {
			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "ImageGrid"])
		}
		.navigationBarTitle(Text("Rouming"), displayMode: .inline)

	}

}

/*extension ImageGridView {

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
}*/
