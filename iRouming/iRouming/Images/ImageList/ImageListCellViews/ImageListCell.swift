//
//  ImageListCell.swift
//  iRouming
//
//  Created by Lope on 29/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageListCell: View {

	@ObservedObject var imageLoader: ImageLoader
	@State var isImageLoaded = false

	let image: RoumingImage

	init(image: RoumingImage) {
		self.image = image
		imageLoader = ImageLoader(url: image.urlThumbnail)
	}

	var body: some View {
		VStack(spacing: 0) {

			HeaderView(headerData: image.headerData)

			WebImage(url: URL(string: image.urlImage))
				// Supports options and context, like `.delayPlaceholder` to show placeholder only when error
				.onSuccess { image, data, cacheType in
					// Success
					// Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
				}
				.resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
				.placeholder {
					Rectangle()
						.foregroundColor(.gray)
						.opacity(0.1)
				}
				//.indicator(.activity) // Activity Indicator
				.transition(.fade(duration: 0.5)) // Fade Transition with duration
				.scaledToFit()


			ImageListCellFooterView(roumingImage: image, isLoggedIn: false)

			if image.isLastSeen {
				LastSeenView()
			}
		}
		.onAppear {
			self.imageLoader.loadImage()
		}
	}

}

struct ImageListCell_Previews: PreviewProvider {
	static var previews: some View {
		ImageListCell(image: RoumingImage(name: "Tajemstvi uspechu podle Burese, Tajemstvi uspechu podle Burese", commentsCount: 2, likes: 10, dislikes: 140))
			.previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/375.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/498.0/*@END_MENU_TOKEN@*/))
	}
}
