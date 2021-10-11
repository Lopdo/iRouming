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

	let image: RoumingImage
	@State private var selectedImage: RoumingImage?
	@State private var commentsImage: RoumingImage?

	var body: some View {
		VStack(spacing: 0) {
			ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
				WebImage(url: URL(string: image.urlThumbnail))
					.resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
					.placeholder {
						Rectangle()
							.foregroundColor(.gray)
							.opacity(0.1)
					}
					.transition(.fade(duration: 0.5)) // Fade Transition with duration
					.aspectRatio(contentMode: .fill)

				if image.isNew {
					NewItemView()
						.padding(4)
				}

			}.onTapGesture {
				selectedImage = image
			}
			.sheet(item: $selectedImage, content: {
				ImageDetailView(image: $0)
			})


			ImageGridFooterView(roumingImage: image, commentsImage: $commentsImage)
				.sheet(item: $commentsImage, content: {
					CommentsView(parent: $0)
				})

		}
		.cornerRadius(6)
	}
	
}

struct ImageGridCell_Previews: PreviewProvider {
	static var previews: some View {
		ImageGridCell(image: RoumingImage(name: "Tajemstvi uspechu podle Burese, Tajemstvi uspechu podle Burese", commentsCount: 2, likes: 10, dislikes: 140))
			.previewLayout(.fixed(width: 120, height: 160))
	}
}
