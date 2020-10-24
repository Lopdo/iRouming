//
//  GifListView.swift
//  iRouming
//
//  Created by Lope on 24/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct GifListView: View {

	@ObservedObject var interactor = GifsInteractor()

	var body: some View {
		Group {
			if interactor.isLoading {
				//TODO: missing design
				Text("Loading")
			} else {
				ScrollView {
					LazyVStack {
						ForEach(interactor.gifs) { gif in
							GifView(gif: gif)
								.padding(.bottom, 12)
						}
					}
				}
				.background(Color(UIColor(hex: 0xEEEEEE)))
			}
		}
		.onAppear {
			if interactor.gifs.isEmpty && !interactor.isLoading {
				interactor.getGifs()
			}
		}
		.navigationBarTitle(Text("Gifník"), displayMode: .inline)
	}

}
