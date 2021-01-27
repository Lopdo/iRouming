//
//  CommentView.swift
//  iRouming
//
//  Created by Lope on 27/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI

struct CommentView: View {

	let comment: Comment

	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			HStack(alignment: .top, spacing: 0) {
				Image("img_thread")
					.padding(4)
				VStack(alignment: .leading, spacing: 16) {
					HStack(alignment: .bottom, spacing: 4) {
						Text(comment.nick)
							.font(.system(size: 13, weight: .semibold))
							.foregroundColor(Color.textBlack)

						if comment.registered {
							RegisteredUserView()
						}

						Spacer()

						Text("20.11.2020 - 14:49")
							.font(.system(size: 11, weight: .regular))
							.foregroundColor(Color.textGray)
					}
					.padding(.top, 8)

					XMLAttributedText(htmlText: comment.htmlMessage, fontSize: 13)
						.foregroundColor(Color.textBlack)
						.lineSpacing(5)
				}
			}
		}.padding(16)
		.background(Color.white)
	}
}

#if DEBUG
struct CommentView_Previews: PreviewProvider {
	static var previews: some View {
		CommentView(comment: Comment(nick: "RoumingUser", registered: false, date: Date(), message: "Samozřejmě první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu střílet ve městě plném lidí po autě."))
			.previewLayout(.sizeThatFits)
	}
}
#endif
