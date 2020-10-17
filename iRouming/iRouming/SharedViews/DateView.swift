//
//  DateView.swift
//  iRouming
//
//  Created by Lope on 16/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct DateView : View {

	let date: Date

	var body: some View {
		Text(getStringFromDate())
			.foregroundColor(.textGray)
			.font(.system(size: 11))
	}

	private func getStringFromDate() -> String {
		let df = DateFormatter()
		if Calendar.current.isDateInToday(date) {
			df.dateFormat = "h:mm"
		} else {
			df.dateFormat = "dd.MM.YYYY"
		}
		return df.string(from: date)
	}
}

struct DateView_Previews : PreviewProvider {
	static var previews: some View {
		DateView(date: Date())
			.previewLayout(.sizeThatFits)
	}
}

