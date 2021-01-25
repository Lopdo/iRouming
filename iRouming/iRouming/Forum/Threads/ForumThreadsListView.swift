//
//  ForumThreadsListView.swift
//  iRouming
//
//  Created by Lope on 02/12/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ForumThreadsListView: View {

	let threads: [ForumThread]
	@Binding var currentThread: ForumThread?
	@Binding var threadsVisible: Bool

	var body: some View {
		GeometryReader { metrics in
			ZStack {
				LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 158.0 / 255.0, blue: 224.0 / 255.0, opacity: 1), Color(red: 0, green: 74.0 / 255.0, blue: 127.0 / 255.0, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.edgesIgnoringSafeArea(.all)

				ScrollView {
					VStack(alignment: .leading, spacing: 0) {
						Text("Seznam aktivních témat")
							.font(.system(size: 17, weight: .bold))
							.foregroundColor(.white)
							.frame(height: 44)
							.padding(.leading, 16)
						ForEach(threads) { thread in
							ForumThreadView(title: thread.title, postsCount: thread.postsCount)
								.background(Color.clear)
								.frame(maxWidth: .infinity)
								.onTapGesture {
									currentThread = thread
									threadsVisible = false
								}
							Color(.white)
								.opacity(0.25)
								.frame(height: 1)
								.padding([.leading, .trailing], 16)
						}
					}
				}

			}
			.frame(width: metrics.size.width * 2 / 3)
		}
	}

}

struct ForumThreadsListView_Previews: PreviewProvider {
	static var previews: some View {
		let threads = [ForumThread(title: "test title", postsCount: 100),
					   ForumThread(title: "Roumenova PC poradna vol. 34680", postsCount: 100),
					   ForumThread(title: "test title", postsCount: 100),
					   ForumThread(title: "test title", postsCount: 100),
					   ForumThread(title: "test title", postsCount: 100),
					   ForumThread(title: "test title", postsCount: 100),
					   ForumThread(title: "test title", postsCount: 100)]

		ForumThreadsListViewPreviewsContainer(value: threads, currentThread: nil, threadsVisible: true)
	}
}

fileprivate struct ForumThreadsListViewPreviewsContainer : View {
	@State var value: [ForumThread]
	@State var currentThread: ForumThread?
	@State var threadsVisible: Bool

	var body: some View {
		ForumThreadsListView(threads: value, currentThread: $currentThread, threadsVisible: $threadsVisible)
	}
}
