//
//  ImageDetailCell.swift
//  iRouming
//
//  Created by Lope on 29/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageDetailCell: View {

	@State var zoomedIn: Bool = false
	private let imageEntity: RoumingImage

	init(imageEntity: RoumingImage) {
		self.imageEntity = imageEntity
	}
	
	var body: some View {
		GeometryReader { geometry in
			WebImage(url: URL(string: imageEntity.urlImage))
				.resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
				.placeholder {
					Rectangle()
						.foregroundColor(.gray)
						.opacity(0.1)
				}
				.transition(.fade(duration: 0.5)) // Fade Transition with duration
				.scaledToFit()
		}


	}
}

