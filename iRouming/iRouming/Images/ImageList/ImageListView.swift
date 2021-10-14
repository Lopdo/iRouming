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

	@ObservedObject var interactor: ImageInteractor

	var body: some View {
		Group {
			if interactor.isLoading && interactor.images.isEmpty {
				LoadingView()
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			} else {
				List(interactor.images) { image in
					ImageListCell(image: image)
				}
				.listStyle(.plain)
				.background(Color.background)
				.refreshable {
					await interactor.getImages()
				}
			}
		}
		.onAppear {
			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "ImageList"])
		}
		.navigationBarTitle(Text("Rouming"), displayMode: .inline)
	}

}

/*extension ImageListView {

	fileprivate init(interactor: Binding<ImageInteractor>, images: [RoumingImage]) {
		_interactor = interactor
		interactor.images = images
	}

}

struct ImageListView_Previews: PreviewProvider {
	static var previews: some View {
		ImageListView(images: [RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140, isLastSeen: true),
							   RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140)])

		ImageListView(images: [])
	}
}*/
