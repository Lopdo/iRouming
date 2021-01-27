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

	@State private var isAnimating: Bool = false
	@State private var showComments: Bool = false

	var body: some View {
		VStack(spacing: 0) {

			HeaderView(headerData: gif.headerData)

			ZStack {
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

				if !isAnimating {
					GifOverlayView()
				}
			}


			VideoFooterView(rating: gif.rating,
							commentsCount: gif.commentsCount,
							shareURL: gif.url,
							showComments: $showComments)

			if gif.isLastSeen {
				LastSeenView()
			}
		}
		.sheet(isPresented: $showComments, content: {
			CommentsView(parent: gif)
		})
	}

}

struct GifView_Previews: PreviewProvider {
	static var previews: some View {
		GifView(gif: Gif(name: "test", commentsCount: 10, rating: 10))
			.previewLayout(.sizeThatFits)
	}
}
