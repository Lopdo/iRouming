//
//  ImageListCellHeaderView.swift
//  iRouming
//
//  Created by Lope on 26/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ImageListCellHeaderView : View {

	let roumingImage: RoumingImage

    var body: some View {
		VStack(alignment: .leading, spacing: 3) {
			HStack(spacing: 0) {
				DateView(date: roumingImage.date)
					.padding(.trailing, 4)
				NewItemView()
				Spacer()
			}
			Text(roumingImage.name)
				.font(.system(size: 17, weight: .bold))
				.foregroundColor(.textBlack)
		}
		.padding(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16))
		.background(Color.white)
    }
}

struct ImageListCellHeaderView_Previews : PreviewProvider {
    static var previews: some View {
        ImageListCellHeaderView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 2, likes: 10, dislikes: 140))
			.previewLayout(.fixed(width: 375.0, height: 70))
    }
}
