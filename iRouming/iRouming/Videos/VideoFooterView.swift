//
//  VideoFooterView.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct VideoFooterView : View {

	let rating: Int
	let commentsCount: Int
	let shareURL: URL

	var body: some View {

			HStack {
				RatingView(rating: rating)

				Spacer()

				CommentsButton(commentsCount: commentsCount) {
					print("tapped comments")
				}
				.padding(.trailing, 20)

				ShareButton(data: shareURL)

			}.padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 6))
			.background(Color.white)

	}
}

struct VideoFooterView_Previews: PreviewProvider {
	static var previews: some View {
		VideoFooterView(rating: 1, commentsCount: 10, shareURL: URL(string: "example.com")!)
			.previewLayout(.sizeThatFits)

	}
}
