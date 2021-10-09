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
			if interactor.isLoading {
				LoadingView()
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			} else {
				ScrollView {
					LazyVStack {
						ForEach(interactor.gifs) { gif in
							GifView(gif: gif)
								.padding(.bottom, 12)
						}
					}
				}
				.background(Color.background)
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
		.task {
			if interactor.gifs.isEmpty && !interactor.isLoading {
				await interactor.getGifs()
			}
		}
		.onAppear {
			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "GifList"])
		}
	}

}
