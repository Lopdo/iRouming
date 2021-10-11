//
//  ImageDetailFooterView.swift
//  iRouming
//
//  Created by Lope on 26/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import ToastUI
import Firebase

struct ImageDetailFooterView : View {

	let roumingImage: RoumingImage
	let isLoggedIn: Bool
	let imageData: UIImage?

	@State var presentingToast: Bool = false
	@State var commentsImage: RoumingImage?
	
	var body: some View {

			HStack {
				HStack {
					if isLoggedIn {
						ImageListCellFooterRatingLoggedInView(roumingImage: roumingImage, lightContent: true)
					} else {
						ImageListCellFooterRatingView(roumingImage: roumingImage, lightContent: true)
					}

					Spacer()
				}

				CommentsButton(commentsCount: roumingImage.commentsCount, color: .white) {
					commentsImage = roumingImage
				}

				HStack {
					Spacer()

					if let image = imageData {
						Button {
							UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

							presentingToast = true

							Analytics.logEvent("download", parameters: nil)
						} label: {
							Image("icn_download")
								.frame(width: 24, height: 24, alignment: .center)
								.foregroundColor(.white)
						}
						.frame(width: 44, height: 44, alignment: .center)
						.toast(isPresented: $presentingToast, dismissAfter: 2.0) {
							ToastView("Uloženo v zařízení") {
								LottieView(name: "check", loopMode: .playOnce)
										.frame(width: 58, height: 58, alignment: .center)
							} background: {
								// empty BG
							}
							.toastViewStyle(RoamingToastViewStyle())
						}
					}

					Spacer()

					ShareButton(data: URL(string: roumingImage.urlImage) ?? URL(string: "https://www.rouming.cz/")!, color: .white)
				}

			}.padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
			.background(Color.black.opacity(0.5))
			.cornerRadius(9)
			.sheet(item: $commentsImage, content: {
				CommentsView(parent: $0)
			})

	}
}

struct ImageDetailFooterView_Previews: PreviewProvider {
	static var previews: some View {
		ImageDetailFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
								isLoggedIn: true, imageData: UIImage(named: "icn_download"))
			.previewLayout(.fixed(width: 320.0, height: 54))
		ImageDetailFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
								isLoggedIn: false, imageData: nil)
			.previewLayout(.fixed(width: 320.0, height: 54))
		ImageDetailFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 10, dislikes: 140),
								isLoggedIn: true, imageData: nil)
			.previewLayout(.fixed(width: 375.0, height: 54))
		ImageDetailFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 10, dislikes: 140),
								isLoggedIn: false, imageData: nil)
			.previewLayout(.fixed(width: 375.0, height: 54))
		ImageDetailFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 10, dislikes: 1),
								isLoggedIn: true, imageData: nil)
			.previewLayout(.fixed(width: 414.0, height: 54))
		ImageDetailFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 10, dislikes: 1),
								isLoggedIn: false, imageData: nil)
			.previewLayout(.fixed(width: 414.0, height: 54))
	}
}
