//
//  ForumPostsView.swift
//  iRouming
//
//  Created by Lope on 17/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ForumPostsView: View {

	@ObservedObject var interactor: ForumInteractor
	
    var body: some View {
		VStack(spacing: 0) {
			if interactor.currentThread != nil {
				HStack {
					Text(interactor.currentThread!.title)
						.font(.system(size: 17, weight: .bold))
						.foregroundColor(Color.textBlack)
						.padding(EdgeInsets(top: 16, leading: 16, bottom: 11, trailing: 0))

					Spacer()

					Button {
						interactor.currentThread = nil
					} label: {
						Image("icn_thread_close")
							.padding(12)
					}
					.padding(.trailing, 4)

				}
				.background(Color
								.backgroundCard
								.shadow(radius: 2))
				.zIndex(1)
			}

			List(interactor.posts(for: interactor.currentThread?.id)) { post in
				PostView(hasTitle: interactor.currentThread == nil, post: post)
			}
			.listStyle(.plain)
			.background(Color.background)
			.refreshable {
				if interactor.currentThread == nil {
					await interactor.getLatestPosts()
				} else {
					await interactor.getPosts(for: interactor.currentThread!.id)
				}
			}
		}
		.background(Color.background)
    }
}

/*
#if DEBUG
struct ForumPostsView_Previews: PreviewProvider {
    static var previews: some View {
		let posts = [ForumPost(title: "ACAB", nick: "RoumingUser", registered: .none, date: Date(), message: "Samozřejmě první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu střílet ve městě plném lidí po autě."),
					 ForumPost(title: "ACAB", nick: "RoumingUser", registered: .registered, date: Date(), message: "*Samozřejmě* první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu <b>střílet</b> ve městě plném lidí po autě."),
					 ForumPost(title: "ACAB", nick: "RoumingUser", registered: .roumen, date: Date(), message: "*Samozřejmě* první problém nastal už v tom, že ho začali ve městě honit")]

		ForumPostsViewPreviewsContainer(posts: posts, currentThread: nil)

		ForumPostsViewPreviewsContainer(posts: posts, currentThread: ForumThread(title: "Current forum thread", postsCount: 10))
    }
}

fileprivate struct ForumPostsViewPreviewsContainer : View {

	@ObservedObject var interactor: ForumInteractor

	var body: some View {
		ForumPostsView(posts: posts, currentThread: $currentThread)
	}
}
#endif
*/
