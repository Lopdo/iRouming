//
//  ImageTabView.swift
//  iRouming
//
//  Created by Lope on 18/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ImageTabView: View {

	@Binding var listSelected: Bool

	var body: some View {

		ZStack {
			GeometryReader() { reader in
				Image(uiImage: AppearanceUtil.tabbarImage())
					.frame(width: reader.size.width, height: 40, alignment: .top)
			}
			HStack {
				VStack(spacing: 0) {
					Text("Seznam")
						.font(.system(size: 13, weight: .bold))
						.foregroundColor(listSelected ? .brandYellow : .white)
						.frame(maxWidth: .infinity, maxHeight: .infinity)

					Group {
						if listSelected {
							Color.yellow
						} else {
							Color(.clear)
						}
					}
					.frame(height: 2)
				}
				.contentShape(Rectangle())
				.onTapGesture {
					listSelected = true
				}

				VStack(spacing: 0) {
					Text("Grid")
						.font(.system(size: 13, weight: .bold))
						.foregroundColor(listSelected ? .white : .brandYellow)
						.frame(maxWidth: .infinity, maxHeight: .infinity)

					Group {
						if !listSelected {
							Color.yellow
						} else {
							Color(.clear)
						}
					}
					.frame(height: 2)
				}
				.contentShape(Rectangle())
				.onTapGesture {
					listSelected = false
				}
			}
		}.frame(height: 40)

	}


}

struct ImageTabView_Previews: PreviewProvider {

	@State static var listSelected = true
	@State static var listDeselected = false

	static var previews: some View {
		ImageTabView(listSelected: $listSelected)
			.previewLayout(.fixed(width: 375.0, height: 40))

		ImageTabView(listSelected: $listDeselected)
			.previewLayout(.fixed(width: 375.0, height: 40))
	}
}
