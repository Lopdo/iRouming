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

	@State var isPlaying: Bool = false

	var body: some View {
		VStack(spacing: 0) {

			HeaderView(headerData: video.headerData)

			/*WebImage(url: video.thumbnailURL)
			.resizable()
			.placeholder {
			Rectangle()
			.foregroundColor(.gray)
			.opacity(0.1)
			}
			//.indicator(.activity) // Activity Indicator
			.transition(.fade(duration: 0.5)) // Fade Transition with duration
			.scaledToFit()*/

			YouTubeVideoView(videoId: video.youtubeId)
				.aspectRatio(480.0 / 360.0, contentMode: .fill)


			VideoFooterView(video: video)

		}
	}

}

struct VideoView_Previews: PreviewProvider {
	static var previews: some View {
		VideoView(video: Video(name: "Sveteľná šabľa", rating: 1, commentsCount: 10, url: "https://www.youtube.com/watch?v=xC6J4T_hUKg", date: Date()))
			.previewLayout(.sizeThatFits)
	}
}

