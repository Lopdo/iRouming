//
//  VideoView.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct VideoView: View {

	let video: Video

	@State private var isPlaying: Bool = false
	@State private var showComments: Bool = false

	var body: some View {
		VStack(spacing: 0) {

			HeaderView(headerData: video.headerData)

			YouTubeVideoView(videoId: video.youtubeId)
				.aspectRatio(480.0 / 360.0, contentMode: .fill)


			VideoFooterView(rating: video.rating,
							commentsCount: video.commentsCount,
							shareURL: URL(string: "https://www.youtube.com/watch?v=\(video.youtubeId)")!,
							showComments: $showComments)

			if video.isLastSeen {
				LastSeenView(lastSeenDate: video.lastSeenDate)
			}
		}
		.sheet(isPresented: $showComments, content: { 
			CommentsView(parent: video)
		})
	}

}

struct VideoView_Previews: PreviewProvider {
	static var previews: some View {
		VideoView(video: Video(name: "Sveteľná šabľa", rating: 1, commentsCount: 10, url: "https://www.youtube.com/watch?v=xC6J4T_hUKg", date: Date()))
			.previewLayout(.sizeThatFits)
	}
}

