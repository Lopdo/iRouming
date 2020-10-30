//
//  ShareButton.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ShareButton: View {

	let data: Any

	var body: some View {
		Button(action: {
			let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
			UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true)
		}, label: {
			Image("icn_share")
				.frame(width: 24, height: 24, alignment: .center)
				.foregroundColor(.textGray)
		})
		.frame(width: 44, height: 44, alignment: .center)
	}
}
