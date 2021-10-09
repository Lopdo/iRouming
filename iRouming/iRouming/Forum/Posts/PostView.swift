//
//  PostView.swift
//  iRouming
//
//  Created by Lope on 17/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI

struct PostView: View {

	let hasTitle: Bool
	let post: ForumPost

    var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			if hasTitle {
				Text(post.title)
					.font(.system(size: 17, weight: .bold))
					.foregroundColor(Color.textBlack)
			}

			HStack(alignment: .top, spacing: 0) {
				Image("img_thread")
					.padding(4)
				VStack(alignment: .leading, spacing: 16) {
					HStack(alignment: .bottom, spacing: 4) {
						Text(post.nick)
							.font(.system(size: 13, weight: .semibold))
							.foregroundColor(Color.textBlack)

						RegistrationStatusView(status: post.registered)

						Spacer()

						Text(getStringFromDate())
							.font(.system(size: 11, weight: .regular))
							.foregroundColor(Color.textGray)
					}
					.padding(.top, 8)

					Text(post.markdownMessage)
						.font(.system(size: 13))
						.lineSpacing(5)
				}
			}
		}.padding(16)
		.background(Color.backgroundCard)
    }

	private func getStringFromDate() -> String {
		let df = DateFormatter()
		if Calendar.current.isDateInToday(post.date) {
			df.dateFormat = "h:mm"
		} else {
			df.dateFormat = "dd.MM.YYYY - h:mm"
		}
		return df.string(from: post.date)
	}
}

#if DEBUG
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
		PostView(hasTitle: true, post: ForumPost(title: "ACAB", nick: "RoumingUser", registered: .none, date: Date(), message: "Samozřejmě první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu střílet ve městě plném lidí po autě."))
			.previewLayout(.sizeThatFits)

		PostView(hasTitle: false, post: ForumPost(title: "ACAB", nick: "RoumingUser", registered: .registered, date: Date().addingTimeInterval(-60*60*24*2), message: "*Samozřejmě* první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu <b>střílet</b> ve městě plném lidí po autě."))
			.previewLayout(.sizeThatFits)

		PostView(hasTitle: true, post: ForumPost(title: "ACAB", nick: "RoumingUser", registered: .roumen, date: Date(), message: "Samozřejmě první problém nastal už v tom, že ho začali ve městě honit"))
			.previewLayout(.sizeThatFits)
    }
}
#endif
