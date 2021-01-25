//
//  ForumThreadPostsCountView.swift
//  iRouming
//
//  Created by Lope on 15/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ForumThreadPostsCountView: View {
	let count: Int
    var body: some View {
		Text(String(count))
			.padding(EdgeInsets(top: 1, leading: 3, bottom: 1, trailing: 3))
			.background(Color.brandYellow)
			.font(.system(size: 11, weight: .bold))
			.foregroundColor(.brandBlue)
			.cornerRadius(3.0)
    }
}

struct ForumThreadPostsCountView_Previews: PreviewProvider {
    static var previews: some View {
		ForumThreadPostsCountView(count: 100)
			.previewLayout(.sizeThatFits)
    }
}
