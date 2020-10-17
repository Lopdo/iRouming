//
//  ImageListCellFooterRatingView.swift
//  iRouming
//
//  Created by Lope on 04/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ImageListCellFooterRatingView : View {

	let roumingImage: RoumingImage
	let lightContent: Bool

	var body: some View {

		HStack(spacing: 0) {
			Text(String(roumingImage.likes))
				.foregroundColor(.ratingGreen)
				.font(.system(size: 15, weight: .bold))
			Text(" / ")
				.font(.system(size: 15, weight: .bold))
				.foregroundColor(lightContent ? .white : .textGray)
			Text(String(roumingImage.dislikes))
				.foregroundColor(.ratingRed)
				.font(.system(size: 15, weight: .bold))
		}

	}
}

struct ImageListCellFooterRatingView_Previews: PreviewProvider {
	static var previews: some View {
		ImageListCellFooterRatingView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 888, dislikes: 888),
									  lightContent: true)
			.previewLayout(.fixed(width: 320.0, height: 64))
	}
}
