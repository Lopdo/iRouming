//
//  VideoFooterView.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct VideoFooterView : View {

	let video: Video

	var body: some View {

			HStack {
				RatingView(rating: video.rating)

				Spacer()

				CommentsButton(commentsCount: video.commentsCount) {
					print("tapped comments")
				}
				.padding(.trailing, 20)

				ShareButton {
					print("tap share")
				}

			}.padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 6))
			.background(Color.white)

	}
}

struct VideoFooterView_Previews: PreviewProvider {
	static var previews: some View {
		VideoFooterView(video: Video(name: "Sveteľná šabľa", rating: 1, commentsCount: 14,  url: "https://www.youtube.com/watch?v=xC6J4T_hUKg", date: Date()))
			.previewLayout(.sizeThatFits)

	}
}
