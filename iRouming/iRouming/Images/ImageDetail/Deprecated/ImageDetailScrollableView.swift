//
//  ImageDetailScrollableView.swift
//  iRouming
//
//  Created by Lope on 29/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ImageDetailScrollableView: View {

	let images: [RoumingImage]
	@State var index: Int

	@Environment(\.presentationMode) var presentationMode

	var currentImage: RoumingImage {
		get {
			return images[index]
		}
	}
	
	var body: some View {
		//ZStack {
			GeometryReader { geometry in
				ScrollViewReader { scrollViewProxy in
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							//TabView {
								ForEach(0..<images.count) { idx in


									GeometryReader { innerGeo in
										//updateIndex(frame: innerGeo.frame(in: .global), superFrame: geometry.size, index: idx)

										//return EmptyView()
										return ImageDetailCell(imageEntity: images[idx])
												.id(images[idx].id)
												.frame(width: geometry.size.width, height: geometry.size.height)

									}
								}
							//}
							//.frame(width: geometry.size.width, height: geometry.size.height)
							//.tabViewStyle(PageTabViewStyle())
						}.onChange(of: index) { target in
							//if let target = target {
								//scrollTarget = nil

								withAnimation {
									scrollViewProxy.scrollTo(target, anchor: .center)
								}
							}
					}/*.onAppear {
						scrollView.scrollTo(currentImage.id)
					}*/
				}
			}


			/*VStack(alignment: .trailing) {
				Image("icn_modal_close")
					.frame(width: 44, height: 44)
					.onTapGesture {
						presentationMode.wrappedValue.dismiss()
					}
				Spacer()
				ImageListCellFooterView(roumingImage: currentImage, isLoggedIn: false)
					.background(Color.black.opacity(0.3))
			}*/

		//}
		//.navigationBarTitle(Text(self.currentImage.name), displayMode: .inline)

	}

	private func updateIndex(frame: CGRect, superFrame: CGSize, index idx: Int) {
		if frame.midX > superFrame.width / 4 && frame.midX <= 3 * superFrame.width / 4 {
			index = idx
			print(index)
		}
	}
}

struct ImageDetailScrollableView_Previews: PreviewProvider {
	static var previews: some View {
		ImageDetailScrollableView(images: [RoumingImage(name: "Tajemstvi uspechu podle Burese, Tajemstvi uspechu podle Burese", commentsCount: 2, likes: 10, dislikes: 140)],
						index: 0)
	}
}

