//
//  CommentsView.swift
//  iRouming
//
//  Created by Lope on 27/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct CommentsView: View {

	@Environment(\.presentationMode) var presentationMode
	
	let parent: Commentable

	@StateObject private var viewModel = ViewModel()

	var body: some View {
		VStack(spacing: 0) {
			HStack(spacing: 16) {
				ZStack {
					WebImage(url: URL(string: parent.urlThumbnail))
						.resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
						.placeholder {
							Rectangle()
								.foregroundColor(.gray)
								.opacity(0.1)
						}
						.transition(.fade(duration: 0.5)) // Fade Transition with duration
						.aspectRatio(contentMode: .fill)
						.frame(width: 64, height: 64)
				}
				.cornerRadius(6)
				.frame(width: 64, height: 64)

				Text(parent.name)
					.font(.system(size: 17, weight: .bold))
					.foregroundColor(Color.textBlack)

				Spacer()

				Button {
					presentationMode.wrappedValue.dismiss()
				} label: {
					Image("icn_thread_close")
						.padding(12)
				}
				.padding(.trailing, 4)

			}
			.padding(10)
			.background(Color
							.backgroundCard
							.shadow(radius: 2))
			.zIndex(1)

			if viewModel.isLoading && viewModel.comments.count == 0 {
				LoadingView()
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			} else {
				List(viewModel.comments) { comment in
					CommentView(comment: comment)
				}
				.listStyle(.plain)
				.background(Color.background)
				.refreshable {
					await viewModel.getComments(for: parent.objectId)
				}
			}

		}
		.background(Color.background)
		.task {
			await viewModel.getComments(for: parent.objectId)
		}
		.onAppear {
			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "Comments"])
		}
	}
}


#if DEBUG

extension CommentsView {

	fileprivate init(comments: [Comment], parent: Commentable) {
		self.parent = parent
		viewModel.comments = comments
	}

}

struct CommentsView_Previews: PreviewProvider {
	static var previews: some View {
		let comments = [Comment(nick: "RoumingUser", registered: .none, date: Date(), message: "Samozřejmě první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu střílet ve městě plném lidí po autě."),
						Comment(nick: "RoumingUser", registered: .registered, date: Date(), message: "*Samozřejmě* první problém nastal už v tom, že ho začali ve městě honit, a on tak zbytečně ohrožoval další lidi, to máš úplnou pravdu. Tam to ani nemělo dojít.\n\nAle na tvou ironickou otázku – ano, některým lidem není příjemné, že mohou dostat odraženou střelou do hlavy jen proto, že někdo cítí potřebu <b>střílet</b> ve městě plném lidí po autě."),
						Comment(nick: "RoumingUser", registered: .roumen, date: Date(), message: "Samozřejmě první problém nastal už v tom")]

		Group {
			CommentsView(comments: comments, parent: RoumingImage(name: "Tajemstvi uspechu podle Burese, Tajemstvi uspechu podle Burese", commentsCount: 2, likes: 10, dislikes: 140))
			CommentsView(comments: comments, parent: RoumingImage(name: "Tajemstvi uspechu podle Burese, Tajemstvi uspechu podle Burese", commentsCount: 2, likes: 10, dislikes: 140))
				.preferredColorScheme(.dark)
		}
	}
}
#endif

