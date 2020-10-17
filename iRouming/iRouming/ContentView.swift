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
				ImageTabWrapView()
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
					Text("Vtipnik")
				}
			}
			.tag(1)

			NavigationView {
				ForumView()
			}
			.tabItem {
				VStack {
					Image("icn_tab_forum")
					Text("Forum")
				}
			}
			.tag(3)
		}
	}
}

struct ContentView_Previews : PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
