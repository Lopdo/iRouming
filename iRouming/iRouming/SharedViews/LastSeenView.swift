//
//  LastSeenView.swift
//  iRouming
//
//  Created by Lope on 29/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct LastSeenView: View {

	var body: some View {
		VStack(spacing: 0) {
			Image("img_all_seen")
			Text("Vsechno ste dohnali")
				.font(.system(size: 20, weight: .bold))
				.foregroundColor(.textBlack)
				.padding(.top, 8)
				.padding(.bottom, 2)
			Text("Viděli jste všechny nové příspěvky z posledních 2 dnů.")
				.font(.system(size: 11))
				.foregroundColor(.textGray)
		}
		.frame(height: 174)
		.frame(maxWidth: .infinity)
		.background(Color(white: 238.0 / 255.0))
	}

}

struct LastSeenView_Previews: PreviewProvider {
	static var previews: some View {
		LastSeenView()
			.previewLayout(.sizeThatFits)
	}
}
