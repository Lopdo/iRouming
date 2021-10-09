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
			if interactor.isLoading {
				LoadingView()
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			} else {
				ScrollView {
					LazyVStack {
						ForEach(0..<interactor.videos.count) { index in
							VideoView(video: interactor.videos[index])
								.padding(.bottom, 12)
						}
					}
				}
				.background(Color.background)
			}
		}
		.onAppear {
			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "VideoList"])
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
		.task {
			if interactor.videos.isEmpty && !interactor.isLoading {
				await interactor.getVideos()
			}
		}
	}

}

extension VideoListView {

	fileprivate init(videos: [Video]) {
		interactor.videos = videos
	}

}
