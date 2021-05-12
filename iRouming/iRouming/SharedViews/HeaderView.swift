//
//  HeaderView.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct HeaderData {
	let date: Date
	let isNew: Bool
	let name: String
	let category: String?
}

struct HeaderView : View {

	let headerData: HeaderData

	var body: some View {
		VStack(alignment: .leading, spacing: 3) {
			HStack(spacing: 4) {
				DateView(date: headerData.date)
				if headerData.isNew {
					NewItemView()
				}
				Spacer()
				if let category = headerData.category {
					Text(category)
						.foregroundColor(.textGray)
						.font(.system(size: 11))
				}
			}
			Text(headerData.name)
				.font(.system(size: 17, weight: .bold))
				.foregroundColor(.textBlack)
		}
		.padding(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16))
		.background(Color.backgroundCard)
	}
}

struct HeaderView_Previews : PreviewProvider {
	static var previews: some View {
		HeaderView(headerData: HeaderData(date: Date(), isNew: true, name: "Tajemstvi uspechu podle Burese", category: nil))
			.previewLayout(.sizeThatFits)
		HeaderView(headerData: HeaderData(date: Date(), isNew: false, name: "Tajemstvi uspechu podle Burese, Tajemstvi uspechu podle Burese", category: "Na zamysleni"))
			.previewLayout(.sizeThatFits)
	}
}

