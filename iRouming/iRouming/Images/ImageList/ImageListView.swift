//
//  ImageListView.swift
//  iRouming
//
//  Created by Lope on 21/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import Firebase

struct ImageListView: View {

	@ObservedObject var interactor = ImageList()

	var body: some View {
		Group {
			if interactor.isLoading {
				LoadingView()
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			} else {
				ScrollView {
					LazyVStack {
						ForEach(interactor.images) { image in
							ImageListCell(image: image)
								.padding(.bottom, 12)
						}
					}
				}
				.background(Color.background)
			}
		}
		.onAppear {
			if interactor.images.isEmpty && !interactor.isLoading {
				interactor.getImages()
			}
			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "ImageList"])

		}
		.navigationBarTitle(Text("Rouming"), displayMode: .inline)
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
		ImageListView(images: [RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140, isLastSeen: true),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140)])

		ImageListView()
	}
}
