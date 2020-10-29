//
//  ImageGridCell.swift
//  iRouming
//
//  Created by Lope on 02/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageGridCell: View {

	@ObservedObject var imageLoader: ImageLoader
	@State var isImageLoaded = false

	let image: RoumingImage

	init(image: RoumingImage) {
		self.image = image
		imageLoader = ImageLoader(url: image.urlThumbnail)
	}

	var body: some View {
		VStack(spacing: 0) {
			ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
				WebImage(url: URL(string: image.urlThumbnail))
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
					.aspectRatio(contentMode: .fill)

				if image.isNew {
					NewItemView()
						.padding(4)
				}

			}

			ImageGridFooterView(roumingImage: image)

		}
		.cornerRadius(6)

		.onAppear {
			self.imageLoader.loadImage()
		}

	}
	
}

struct ImageGridCell_Previews: PreviewProvider {
	static var previews: some View {
		ImageGridCell(image: RoumingImage(name: "Tajemstvi uspechu podle Burese, Tajemstvi uspechu podle Burese", commentsCount: 2, likes: 10, dislikes: 140))
			.previewLayout(.fixed(width: 120, height: 120))
	}
}
