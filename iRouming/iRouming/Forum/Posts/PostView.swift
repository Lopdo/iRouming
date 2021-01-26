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

						if post.registered {
							RegisteredUserView()
						}

						Spacer()

						Text("20.11.2020 - 14:49")
							.font(.system(size: 11, weight: .regular))
							.foregroundColor(Color.textGray)
					}
					.padding(.top, 8)

					XMLAttributedText(htmlText: post.htmlMessage, fontSize: 13)
						//.font(.system(size: 13, weight: .regular))
						.foregroundColor(Color.textBlack)
						.lineSpacing(5)
				}
			}
		}.padding(16)
		.background(Color.white)
    }
}

#if DEBUG
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(hasTitle: true, post: ForumPost(title: "ACAB", nick: "RoumingUser", registered: false, date: Date(), message: "Samozřejmě první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu střílet ve městě plném lidí po autě."))
			.previewLayout(.sizeThatFits)

		PostView(hasTitle: false, post: ForumPost(title: "ACAB", nick: "RoumingUser", registered: true, date: Date(), message: "<i>Samozřejmě</i> první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu <b>střílet</b> ve městě plném lidí po autě."))
			.previewLayout(.sizeThatFits)
    }
}
#endif
