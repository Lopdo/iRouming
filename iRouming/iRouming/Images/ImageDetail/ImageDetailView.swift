//
//  ImageDetailView.swift
//  iRouming
//
//  Created by Lope on 18/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

private class DisplayedImage {
	let image: RoumingImage
	var size: CGSize = .zero

	init(image: RoumingImage) {
		self.image = image
	}
}

struct ImageDetailView: View {

	//let image: RoumingImage
	private let image: DisplayedImage

	@Environment(\.presentationMode) var presentationMode

	@State private var scale: CGFloat = 1.0
	@State private var lastScale: CGFloat = 1.0

	@State private var viewOriginalOffset = CGSize.zero
	@State private var viewOffset = CGSize.zero

	@State private var imageData: UIImage? {
		didSet {
			if let imageData = imageData {
				image.size = imageData.size
			}
		}
	}
	//@State private var imageSize: CGSize = .zero

	init(image: RoumingImage) {
		self.image = DisplayedImage(image: image)
	}

	var body: some View {
		GeometryReader() { geometry in
			ZStack {
				//GeometryReader() { imageGeometry in
				WebImage(url: URL(string: image.image.urlImage))
						.resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
						.placeholder {
							Rectangle()
								.foregroundColor(.gray)
								.opacity(0.1)
						}
						.onSuccess(perform: { image in
							DispatchQueue.main.async {
								imageData = image
							}
							//self.image.size = image.size
							//var newScale = min(image.size.width / geometry.size.width, image.size.height / geometry.size.height)
							//self.scale = newScale
						})
						//.indicator(.activity) // Activity Indicator
						.transition(.fade(duration: 0.5)) // Fade Transition with duration
			
						.aspectRatio(contentMode: .fit)
						.offset(x: viewOffset.width, y: viewOffset.height)
						.scaleEffect(scale, anchor: .center)
						.gesture(DragGesture()
									.onChanged { val in
										var newViewOffset = CGSize(width: viewOriginalOffset.width + val.translation.width,
																   height: viewOriginalOffset.height + val.translation.height)
										let displayedSize = CGSize(width: self.image.size.width * scale, height: self.image.size.height * scale)
										let overflow = CGSize(width: displayedSize.width - geometry.size.width, height: displayedSize.height - geometry.size.height)
										print("geometry:", geometry.size)
										print("overflow:", overflow)
										print("newViewOffset:", newViewOffset)
										if newViewOffset.width > overflow.width {
											newViewOffset.width = overflow.width
										}
										if newViewOffset.width < -overflow.width {
											newViewOffset.width = -overflow.width
										}
										viewOffset = newViewOffset
										print(displayedSize)
										print(viewOffset)
									}
									.onEnded { val in
										viewOriginalOffset = viewOffset
									}
						)
						.gesture(MagnificationGesture()
									.onChanged { val in
										let delta = val / lastScale
										lastScale = val
										var newScale = scale * delta
										if newScale < 1 {
											newScale = 1
										}
										scale = newScale
										print(scale)
									}
									.onEnded { _ in
										lastScale = 1.0
									}
						)

				//}

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
					ImageDetailFooterView(roumingImage: image.image, isLoggedIn: false, imageData: imageData)
						.padding(.all, 16)
				}

			}
			.background(Color.black)
		}
		.navigationBarTitle(Text(image.image.name), displayMode: .inline)
		.edgesIgnoringSafeArea(.top)
	}

}

struct ImageDetailView_Previews: PreviewProvider {
	static var previews: some View {
		ImageDetailView(image: RoumingImage(name: "Tajemstvi uspechu podle Burese, Tajemstvi uspechu podle Burese", commentsCount: 2, likes: 10, dislikes: 140))
	}
}

