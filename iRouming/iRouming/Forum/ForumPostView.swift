//
//  ForumPostView.swift
//  iRouming
//
//  Created by Lope on 13/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ForumPostView: View {

	let post: ForumPost

	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text(post.title)
				Spacer()
				Text(post.nick)
			}

			Divider()

			Text(post.htmlMessage.string)
				.lineLimit(nil)

		}

	}
}
