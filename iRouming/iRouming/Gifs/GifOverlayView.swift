//
//  GifOverlayView.swift
//  iRouming
//
//  Created by Lope on 29/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct GifOverlayView: View {

	var body: some View {
		Image("img_gif_play")
			.frame(minWidth: 0,
				   maxWidth: .infinity,
				   minHeight: 0,
				   maxHeight: .infinity,
				   alignment: .center
			)
			.background(Color.black.opacity(0.5))
			.allowsHitTesting(false)
	}

}
