//
//  ImageGridFooterView.swift
//  iRouming
//
//  Created by Lope on 02/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ImageGridFooterView: View {

	let roumingImage: RoumingImage

	var body: some View {
		VStack(alignment: .leading, spacing: 3) {
			Text(roumingImage.name)
				.font(.system(size: 11, weight: .bold))
				.foregroundColor(.textBlack)
				.lineLimit(1)
			HStack(spacing: 0) {
				Text(String(roumingImage.likes))
					.foregroundColor(.ratingGreen)
					.font(.system(size: 11, weight: .bold))
				Text(" / ")
					.font(.system(size: 11, weight: .bold))
					.foregroundColor(.textGray)
				Text(String(roumingImage.dislikes))
					.foregroundColor(.ratingRed)
					.font(.system(size: 11, weight: .bold))
				Spacer()
				HStack(spacing: 2) {
					Image("icn_comments")
						.resizable()
						.frame(width: 16, height: 16, alignment: .center)
						.foregroundColor(.textGray)
					Text(String(roumingImage.commentsCount))
						.foregroundColor(.textGray)
						.font(.system(size: 11, weight: .bold))
				}
			}

		}
		.padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
		.background(Color.white)
	}
	
}

struct ImageGridFooterView_Previews: PreviewProvider {
	static var previews: some View {
		ImageGridFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 2, likes: 10, dislikes: 140))
			.previewLayout(.fixed(width: 120.0, height: 45))
	}
}

