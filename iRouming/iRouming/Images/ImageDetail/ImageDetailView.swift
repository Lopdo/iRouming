//
//  ImageDetailView.swift
//  iRouming
//
//  Created by Lope on 18/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageDetailView: View {

	let image: RoumingImage

	@Environment(\.presentationMode) var presentationMode

	@State private var imageData: UIImage?

	var body: some View {
		ZStack {
			ZoomableScrollView {
				WebImage(url: URL(string: image.urlImage))
					.resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
					.placeholder {
						Rectangle()
							.foregroundColor(.gray)
							.opacity(0.1)
					}
					.onSuccess(perform: { (image, _, _)  in
						DispatchQueue.main.async {
							imageData = image
						}
					})
					.transition(.fade(duration: 0.5)) // Fade Transition with duration
					.aspectRatio(contentMode: .fit)
			}

			VStack(alignment: .trailing) {
				Image("icn_modal_close")
					.frame(width: 56, height: 56)
					.onTapGesture {
						presentationMode.wrappedValue.dismiss()
					}
					.background(Color.black.opacity(0.5))
					.cornerRadius(9)
					.padding([.trailing, .top], 16)
				Spacer()
				ImageDetailFooterView(roumingImage: image, isLoggedIn: false, imageData: imageData)
					.padding(.all, 16)
			}

		}
		.navigationBarTitle(Text(image.name), displayMode: .inline)
		.edgesIgnoringSafeArea(.top)
	}

}

struct ImageDetailView_Previews: PreviewProvider {
	static var previews: some View {
		ImageDetailView(image: RoumingImage(name: "Tajemstvi uspechu podle Burese, Tajemstvi uspechu podle Burese", commentsCount: 2, likes: 10, dislikes: 140))
	}
}
