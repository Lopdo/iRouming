//
//  RoamingToastStyle.swift
//  iRouming
//
//  Created by Lope on 13/02/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI
import ToastUI

public struct RoamingToastViewStyle: ToastViewStyle {
	/// Creates a default `ToastViewStyle`.
	public init() {}

	/// Creates a view representing the body of a `ToastView`.
	///
	/// - Parameter configuration: The properties of the `ToastView` being created.
	public func makeBody(configuration: Configuration) -> some View {
		DefaultToastView(
			background: configuration.background,
			label: configuration.label,
			content: configuration.content
		)
	}

	struct DefaultToastView: View {
		@ScaledMetric(relativeTo: .headline) private var paddingSize: CGFloat = 16
		@ScaledMetric(relativeTo: .headline) private var cornerSize: CGFloat = 9

		let background: AnyView?
		let label: AnyView?
		let content: AnyView?

		var body: some View {
			VStack {
				content
				label
					.fixedSize()
					.foregroundColor(.textBlack)
					.font(.system(size: 15, weight: .bold))
			}
			.padding(paddingSize)
			.background(Color.backgroundToast.opacity(0.85))
			.cornerRadius(cornerSize)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(background.edgesIgnoringSafeArea(.all))
			.shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 17)
		}
	}
}
