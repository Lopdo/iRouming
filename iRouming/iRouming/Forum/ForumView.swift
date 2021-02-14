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

	@State var threadsVisible: Bool = false
	@State var showingDetail = false
	@ObservedObject var interactor = ForumInteractor()

	var body: some View {
		GeometryReader { metrics in
			ZStack {
				ForumThreadsListView(threads: interactor.threads, currentThread: $interactor.currentThread, threadsVisible: $threadsVisible)

				NavigationView {
					Group {
						if interactor.isLoadingPosts || interactor.isLoadingThreads {
							LoadingView()
								.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
						} else {
							ForumPostsView(posts: interactor.postsForCurrentThread(), currentThread: $interactor.currentThread)
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
					}).disabled(interactor.isLoadingPosts),
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
				.background(Color.white.shadow(color: Color.black.opacity(0.7), radius: 25))
				.offset(x: threadsVisible ? metrics.size.width * 2 / 3 : 0, y: 0)

			}
		}.onAppear {
			if self.interactor.postsForCurrentThread().isEmpty && !self.interactor.isLoadingPosts {
				self.interactor.getLatestPosts()
				self.interactor.getThreads()
			}

			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "Forum"])
		}.navigationBarTitle(Text("Fórum"))
	}

}


struct ForumView_Previews: PreviewProvider {
	static var previews: some View {
		ForumView()
	}
}
