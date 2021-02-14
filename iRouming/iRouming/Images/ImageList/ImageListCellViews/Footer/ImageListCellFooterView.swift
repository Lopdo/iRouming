//
//  ImageListCellFooterView.swift
//  iRouming
//
//  Created by Lope on 26/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import Firebase
import ToastUI

struct ImageListCellFooterView : View {

	let roumingImage: RoumingImage
	let isLoggedIn: Bool
	let imageData: UIImage?

	@State var presentingToast: Bool = false
	@Binding var commentsImage: RoumingImage?
	
    var body: some View {

			HStack {
				HStack {
					if isLoggedIn {
						ImageListCellFooterRatingLoggedInView(roumingImage: roumingImage, lightContent: false)
					} else {
						ImageListCellFooterRatingView(roumingImage: roumingImage, lightContent: false)
					}

					Spacer()
				}

				CommentsButton(commentsCount: roumingImage.commentsCount) {
					commentsImage = roumingImage
				}
				.sheet(item: $commentsImage, content: {
					CommentsView(parent: $0)
				})

				HStack {
					Spacer()

					if let image = imageData {
						Button(action: {
							UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

							presentingToast = true
							
							Analytics.logEvent("download", parameters: nil)
						}, label: {
							Image("icn_download")
								.frame(width: 24, height: 24, alignment: .center)
								.foregroundColor(.textGray)
						})
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
						
						Spacer()
					}


					ShareButton(data: URL(string: roumingImage.urlImage) ?? URL(string: "https://www.rouming.cz/")!)
				}
				
			}.padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
			.background(Color.white)

    }
}
/*
struct ImageListCellFooterView_Previews: PreviewProvider {
	static var previews: some View {
		ImageListCellFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
								isLoggedIn: true, imageData: UIImage(named: ""))
			.previewLayout(.fixed(width: 320.0, height: 54))
		ImageListCellFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 1000, dislikes: 140),
								isLoggedIn: false, imageData: nil)
			.previewLayout(.fixed(width: 320.0, height: 54))
		ImageListCellFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 10, dislikes: 140),
								isLoggedIn: true, imageData: nil)
			.previewLayout(.fixed(width: 375.0, height: 54))
		ImageListCellFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 10, dislikes: 140),
								isLoggedIn: false, imageData: UIImage(named: ""))
			.previewLayout(.fixed(width: 375.0, height: 54))
		ImageListCellFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 10, dislikes: 1),
								isLoggedIn: true, imageData: nil)
			.previewLayout(.fixed(width: 414.0, height: 54))
		ImageListCellFooterView(roumingImage: RoumingImage(name: "Tajemstvi uspechu podle Burese", commentsCount: 245, likes: 10, dislikes: 1),
								isLoggedIn: false, imageData: nil)
			.previewLayout(.fixed(width: 414.0, height: 54))
	}
}
*/
