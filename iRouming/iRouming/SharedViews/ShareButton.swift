//
//  ShareButton.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI
import Firebase

struct ShareButton: View {

	let data: Any
	var color: Color = .textGray
	
	var body: some View {
		Button(action: {
			let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
			UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true)

			Analytics.logEvent(AnalyticsEventShare, parameters: nil)
		}, label: {
			Image("icn_share")
				.frame(width: 24, height: 24, alignment: .center)
				.foregroundColor(color)
		})
		.frame(width: 44, height: 44, alignment: .center)
	}
}
