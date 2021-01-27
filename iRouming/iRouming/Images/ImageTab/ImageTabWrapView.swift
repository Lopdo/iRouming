//
//  ImageTabWrapView.swift
//  iRouming
//
//  Created by Lope on 18/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ImageTabWrapView: View {

	@State var listSelected: Bool = true

	var body: some View {
		VStack(spacing: 0) {
			ImageTabView(listSelected: $listSelected)

			if listSelected {
				ImageListView()
			} else {
				ImageGridView()
			}
		}
		.navigationBarItems(trailing:
				NavigationLink(destination: AboutView()) {
					Image("icn_navbar_info")
				}
		)
	}

}
