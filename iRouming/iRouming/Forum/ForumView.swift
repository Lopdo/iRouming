//
//  ForumView.swift
//  iRouming
//
//  Created by Lope on 13/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ForumView: View {

	@ObservedObject var interactor = ForumInteractor()

	var body: some View {
		Group {
			if interactor.isLoading {
				Text("Loading")
			}
			List(interactor.posts) { post in
				ForumPostView(post: post)
			}
		}.onAppear {
			if self.interactor.posts.isEmpty && !self.interactor.isLoading {
				self.interactor.getLatestPosts()
			}
		}.navigationBarTitle(Text("Forum"))
	}

}

