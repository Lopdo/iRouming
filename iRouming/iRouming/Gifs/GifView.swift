//
//  GifView.swift
//  iRouming
//
//  Created by Lope on 24/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct GifView: View {

	let gif: Gif

	@State var isAnimating: Bool = false

	var body: some View {
		VStack(spacing: 0) {

			HeaderView(headerData: gif.headerData)

			WebImage(url: gif.url, context: [.animatedImageClass: SDAnimatedImage.self], isAnimating: $isAnimating)
				.onFailure { error in
					print(error)
				}
				.resizable()
				.placeholder {
					Rectangle()
						.foregroundColor(.gray)
						.opacity(0.1)
				}
				.scaledToFit()
				.onTapGesture {
					isAnimating = !isAnimating
				}

			VideoFooterView(rating: gif.rating, commentsCount: gif.commentsCount)
		}
	}

}
