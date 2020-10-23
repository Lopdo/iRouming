//
//  YouTubeVideoView.swift
//  iRouming
//
//  Created by Lope on 23/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct YouTubeVideoView: UIViewRepresentable {

	private let videoId: String

	init(videoId: String) {
		self.videoId = videoId
	}

	func updateUIView(_ uiView: YTPlayerView, context: Context) { }

	func makeUIView(context: Context) -> YTPlayerView {
		let view = YTPlayerView()
		view.load(withVideoId: videoId)
		return view
	}

}
