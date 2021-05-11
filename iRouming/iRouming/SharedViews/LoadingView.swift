//
//  LoadingView.swift
//  iRouming
//
//  Created by Lope on 13/02/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI
import Lottie

struct LoadingView: View {

	var body: some View {
		Group {
			LottieView(name: "loading", loopMode: .loop)
				.frame(width: 48, height: 48, alignment: .center)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
		.background(Color.background)
	}

}

struct LoadingView_Previews: PreviewProvider {
	static var previews: some View {
		LoadingView()
	}
}


struct LottieView: UIViewRepresentable {
	var name = ""
	var loopMode: LottieLoopMode = .loop

	func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
		let view = UIView(frame: .zero)

		let animationView = AnimationView()
		let animation = Animation.named(name)
		animationView.animation = animation
		animationView.contentMode = .scaleAspectFit
		animationView.loopMode = loopMode
		animationView.play()

		animationView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(animationView)
		NSLayoutConstraint.activate([
			animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
			animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
		])

		return view
	}

	func updateUIView(_ uiView: UIViewType, context: Context) {
	}
}
