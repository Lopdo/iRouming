//
//  LastSeenView.swift
//  iRouming
//
//  Created by Lope on 29/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct LastSeenView: View {

	let lastSeenDate: Date
	
	var body: some View {
		VStack(spacing: 0) {
			Image("img_all_seen")
			Text("Dobrá zpráva!")
				.font(.system(size: 20, weight: .bold))
				.foregroundColor(.textBlack)
				.padding(.top, 8)
				.padding(.bottom, 2)
			Text("Viděli jste všechny nové příspěvky od \(getStringFromDate())")
				.font(.system(size: 11))
				.foregroundColor(.textGray)
		}
		.frame(height: 174)
		.frame(maxWidth: .infinity)
		.background(Color.background)
	}

	private func getStringFromDate() -> String {
		let df = DateFormatter()
		if Calendar.current.isDateInToday(lastSeenDate) {
			df.dateFormat = "h:mm"
		} else {
			df.dateFormat = "dd.MM.YYYY"
		}
		return df.string(from: lastSeenDate)
	}
}

struct LastSeenView_Previews: PreviewProvider {
	static var previews: some View {
		LastSeenView(lastSeenDate: Date())
			.previewLayout(.sizeThatFits)

		LastSeenView(lastSeenDate: Date().addingTimeInterval(-60*60*28*2))
			.preferredColorScheme(.dark)
			.previewLayout(.sizeThatFits)
	}
}
