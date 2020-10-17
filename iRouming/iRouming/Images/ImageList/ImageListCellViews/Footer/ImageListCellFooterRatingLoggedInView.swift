//
//  ImageListCellFooterRatingLoggedInView.swift
//  iRouming
//
//  Created by Lope on 04/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ImageListCellFooterRatingLoggedInView : View {

	let roumingImage: RoumingImage
	let lightContent: Bool
	
	var body: some View {

		HStack(spacing: 8) {
			Button(action: {
				print("tap")
			}, label: {
				HStack(spacing: 3) {
					Image("icn_rating_plus")
						.frame(width: 24, height: 24, alignment: .center)
						.foregroundColor(lightContent ? .white : .textGray)
					Text(String(roumingImage.likes))
						.foregroundColor(.green)
						.font(.system(size: 15, weight: .semibold))
						.lineLimit(1)
						.minimumScaleFactor(0.5)
				}
			}).frame(minWidth: 44, minHeight: 44)

			Button(action: {
				print("tap tap")
			}, label: {
				HStack(spacing: 3) {
					Image("icn_rating_minus")
						.frame(width: 24, height: 24, alignment: .center)
						.foregroundColor(lightContent ? .white : .textGray)
					Text(String(roumingImage.dislikes))
						.foregroundColor(.red)
						.font(.system(size: 15, weight: .semibold))
						.lineLimit(1)
						.minimumScaleFactor(0.5)
				}
			}).frame(minWidth: 44, minHeight: 44)
		}

	}
}

struct ImageListCellFooterRatingLoggedInView_Previews: PreviewProvider {
	static var previews: some View {
		ImageListCellFooterRatingLoggedInView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 888, dislikes: 888),
											  lightContent: false)
			.previewLayout(.fixed(width: 320.0, height: 64))
	}
}
