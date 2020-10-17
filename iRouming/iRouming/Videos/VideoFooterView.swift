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
				Button(action: {
					print("tap comments")
				}, label: {
					HStack(spacing: 6) {
						Image("icn_comments")
							.frame(width: 24, height: 24, alignment: .center)
							.foregroundColor(.textGray)
						Text(String(video.commentsCount))
							.foregroundColor(.textGray)
							.font(.system(size: 15, weight: .bold))
					}
				})
				.frame(minWidth: 44, minHeight: 44)
				.padding(.trailing, 20)

				Button(action: {
					print("tap share")
				}, label: {
					Image("icn_share")
						.frame(width: 24, height: 24, alignment: .center)
						.foregroundColor(.textGray)
				})
				.frame(width: 44, height: 44, alignment: .center)

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
