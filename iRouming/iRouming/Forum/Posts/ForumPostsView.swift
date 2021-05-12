//
//  ForumPostsView.swift
//  iRouming
//
//  Created by Lope on 17/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ForumPostsView: View {

	var posts: [ForumPost]

	@Binding var currentThread: ForumThread?

    var body: some View {
		VStack(spacing: 0) {
			if currentThread != nil {
				HStack {
					Text(currentThread!.title)
						.font(.system(size: 17, weight: .bold))
						.foregroundColor(Color.textBlack)
						.padding(EdgeInsets(top: 16, leading: 16, bottom: 11, trailing: 0))

					Spacer()

					Button(action: {
						currentThread = nil
					}, label: {
						Image("icn_thread_close")
							.padding(12)
					}).padding(.trailing, 4)

				}
				.background(Color
								.backgroundCard
								.shadow(radius: 2))
				.zIndex(1)
			}
			ScrollView {
				LazyVStack(spacing: 12) {
					ForEach(posts) { post in
						PostView(hasTitle: currentThread == nil, post: post)
					}
				}.padding(.top, 10)
			}
		}
		.background(Color.background)
    }
}

#if DEBUG
struct ForumPostsView_Previews: PreviewProvider {
    static var previews: some View {
		let posts = [ForumPost(title: "ACAB", nick: "RoumingUser", registered: false, date: Date(), message: "Samozřejmě první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu střílet ve městě plném lidí po autě."),
					 ForumPost(title: "ACAB", nick: "RoumingUser", registered: true, date: Date(), message: "<i>Samozřejmě</i> první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu <b>střílet</b> ve městě plném lidí po autě.")]

		ForumPostsViewPreviewsContainer(posts: posts, currentThread: nil)

		ForumPostsViewPreviewsContainer(posts: posts, currentThread: ForumThread(title: "Current forum thread", postsCount: 10))
    }
}

fileprivate struct ForumPostsViewPreviewsContainer : View {
	var posts: [ForumPost]
	@State var currentThread: ForumThread?

	var body: some View {
		ForumPostsView(posts: posts, currentThread: $currentThread)
	}
}
#endif
