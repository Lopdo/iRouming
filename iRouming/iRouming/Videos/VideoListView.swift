//
//  VideoListView.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI


struct VideoListView: View {

	@ObservedObject var interactor = VideosInteractor()

	var body: some View {
		Group {
			if interactor.isLoading {
				//TODO: missing design
				Text("Loading")
			} else {
				ScrollView {
					LazyVStack {
						ForEach(0..<interactor.videos.count) { index in
							VideoView(video: interactor.videos[index])
								.padding(.bottom, 12)
							/*ImageListCell(image: interactor.images[index])
								.onTapGesture {
									selectedIndex = index
									isShowingDetailView = true
								}.padding(.bottom, 12)*/
						}
					}
				}
				.background(Color(UIColor(hex: 0xEEEEEE)))
			}
		}
		.onAppear {
			if interactor.videos.isEmpty && !interactor.isLoading {
				interactor.getVideos()
			}
		}
		.navigationBarTitle(Text("Videjník"), displayMode: .inline)
		.navigationBarItems(trailing:
				NavigationLink(destination: AboutView()) {
					Image("icn_navbar_info")
				}
		)
	}

}

extension VideoListView {

	fileprivate init(videos: [Video]) {
		interactor.videos = videos
	}

}
