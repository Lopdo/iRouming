//
//  ImageDetailCell.swift
//  iRouming
//
//  Created by Lope on 29/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageDetailCell: View {

	//@ObservedObject var imageLoader: ImageLoader// = ImageLoader()
	@State var zoomedIn: Bool = false
	private let imageEntity: RoumingImage

	init(imageEntity: RoumingImage) {
		self.imageEntity = imageEntity
		//imageLoader.url = imageEntity.urlImage
		//imageLoader = ImageLoader(url: imageEntity.urlImage)
	}
	
	var body: some View {
		GeometryReader { geometry in
			WebImage(url: URL(string: imageEntity.urlImage))
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
			//.frame(width: 300, height: 300, alignment: .center)
			//.frame(height: 75)

			/*Group {
				if let image =  imageLoader.image {
					Image(uiImage: image)
						.resizable()
						.aspectRatio(image.size.width / image.size.height, contentMode: zoomedIn ? .fill : .fit)
						.frame(maxHeight: geometry.size.height)
						.padding(.horizontal)
				} else {
					Rectangle()
						.foregroundColor(.gray)
						//.opacity(0.1)
						.opacity(Double.random(in: 0...1))
				}
			}
			.onAppear {
				imageLoader.loadImage()
			}
			.onTapGesture {
				zoomedIn.toggle()
			}*/
		}


	}
}

