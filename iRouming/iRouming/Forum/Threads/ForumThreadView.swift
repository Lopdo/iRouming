//
//  ForumThreadView.swift
//  iRouming
//
//  Created by Lope on 15/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ForumThreadView: View {

	let title: String
	let postsCount: Int

    var body: some View {
		HStack(spacing: 12) {
			Text(title)
				.font(.system(size: 13, weight: .bold))
				.foregroundColor(.white)
			Spacer()
			ForumThreadPostsCountView(count: postsCount)
		}.padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
		.background(Color.clear)
    }
}

struct ForumThreadView_Previews: PreviewProvider {
    static var previews: some View {
        ForumThreadView(title: "test", postsCount: 10)
			.previewLayout(.sizeThatFits)
    }
}
