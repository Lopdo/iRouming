//
//  ContentView.swift
//  iRouming
//
//  Created by Lope on 21/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ContentView : View {
	@State private var selection = 0

	init() {
		AppearanceUtil.setupBarsAppearance()
	}

	var body: some View {
		TabView(selection: $selection) {
			NavigationView {
				ImagesView()
			}
			.tabItem {
				VStack {
					Image("icn_tab_images")
					Text("Rouming")
				}
			}
			.tag(0)

			NavigationView {
				JokesListView()
			}
			.tabItem {
				VStack {
					Image("icn_tab_jokes")
					Text("Vtipník")
				}
			}
			.tag(1)

			NavigationView {
				VideoListView()
			}
			.tabItem {
				VStack {
					Image("icn_tab_videos")
					Text("Videjník")
				}
			}
			.tag(2)

			NavigationView {
				GifListView()
			}
			.tabItem {
				VStack {
					Image("icn_tab_gifs")
					Text("GIFník")
				}
			}
			.tag(3)

			ForumView()
			.tabItem {
				VStack {
					Image("icn_tab_forum")
					Text("Fórum")
				}
			}
			.tag(4)
		}
	}
}

struct ContentView_Previews : PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
