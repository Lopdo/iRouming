//
//  VideoListView.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI
import Firebase

struct VideoListView: View {

	@StateObject var interactor = VideosInteractor()
	@State var showingDetail = false
	
	var body: some View {
		Group {
			if interactor.isLoading && interactor.videos.isEmpty {
				LoadingView()
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			} else {
				List(interactor.videos) { video in
					VideoView(video: video)
				}
				.listStyle(.plain)
				.background(Color.background)
				.refreshable {
					await interactor.getVideos()
				}
			}
		}
		.navigationBarTitle(Text("Videjník"), displayMode: .inline)
		.navigationBarItems(trailing:
								Button(action: {
									self.showingDetail.toggle()
								}) {
									Image("icn_navbar_info")
								}.sheet(isPresented: $showingDetail) {
									AboutView()
								}
		)
		.onAppear {
			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "VideoList"])
		}
	}

}

extension VideoListView {

	fileprivate init(videos: [Video]) {
		interactor.videos = videos
	}

}
