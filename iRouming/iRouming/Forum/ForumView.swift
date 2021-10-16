//
//  ForumView.swift
//  iRouming
//
//  Created by Lope on 13/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import Firebase

struct ForumView: View {

	@State private var threadsVisible: Bool = false
	@State private var showingDetail = false
	@StateObject private var viewModel = ViewModel()

	var body: some View {
		GeometryReader { metrics in
			ZStack {
				ForumThreadsListView(threads: viewModel.threads, currentThread: $viewModel.currentThread, threadsVisible: $threadsVisible)

				NavigationView {
					Group {
						if (viewModel.isLoadingPosts && viewModel.posts(for: viewModel.currentThread?.id).count == 0)
						|| (viewModel.isLoadingThreads && viewModel.threads.count == 0) {
							LoadingView()
								.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
						} else {
							ForumPostsView(viewModel: viewModel)
						}
					}
					.navigationBarTitle(Text("Fórum"), displayMode: .inline)
					.navigationBarItems(leading: Button(action: {
						withAnimation(.easeOut(duration: 0.3)) {
							threadsVisible.toggle()

							if threadsVisible {
								Analytics.logEvent(AnalyticsEventScreenView,
												   parameters: [AnalyticsParameterScreenName: "ForumThreads"])
							} else {
								Analytics.logEvent(AnalyticsEventScreenView,
												   parameters: [AnalyticsParameterScreenName: "ForumList"])
							}
						}
					}, label: {
						Image(threadsVisible ? "icn_navbar_close" : "icn_hamburger_menu")
					}).disabled(viewModel.isLoadingPosts),
						trailing:
							Button(action: {
								self.showingDetail.toggle()
							}) {
								Image("icn_navbar_info")
							}.sheet(isPresented: $showingDetail) {
								AboutView()
							}
					)
				}
				.background(Color.backgroundCard.shadow(color: Color.black.opacity(0.7), radius: 25))
				.offset(x: threadsVisible ? metrics.size.width * 2 / 3 : 0, y: 0)

			}
		}
		.navigationBarTitle(Text("Fórum"))
		.task {
			if viewModel.postsForCurrentThread().isEmpty && !viewModel.isLoadingPosts {
				async let posts: () = viewModel.getLatestPosts()
				async let threads: () = viewModel.getThreads()
				_ = await (posts, threads)
			}
		}
		.onAppear {
			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "Forum"])
		}
	}

}


struct ForumView_Previews: PreviewProvider {
	static var previews: some View {
		ForumView()
	}
}
