//
//  GifListView.swift
//  iRouming
//
//  Created by Lope on 24/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI
import Firebase

struct GifListView: View {

	@StateObject var interactor = GifsInteractor()
	@State var showingDetail = false
	
	var body: some View {
		Group {
			if interactor.isLoading && interactor.gifs.isEmpty {
				LoadingView()
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			} else {
				List(interactor.gifs) { gif in
					GifView(gif: gif)
				}
				.listStyle(.plain)
				.background(Color.background)
				.refreshable {
					await interactor.getGifs()
				}
			}
		}
		.navigationBarTitle(Text("GIFník"), displayMode: .inline)
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
							   parameters: [AnalyticsParameterScreenName: "GifList"])
		}
	}

}
