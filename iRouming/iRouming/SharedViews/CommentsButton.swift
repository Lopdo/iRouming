//
//  CommentsButton.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct CommentsButton: View {

	let commentsCount: Int
	var color: Color = .textGray
	let action: () -> ()

	var body: some View {
		Button{
			action()
		} label: {
			HStack(spacing: 6) {
				Image("icn_comments")
					.frame(width: 24, height: 24, alignment: .center)
					.foregroundColor(color)
				Text(String(commentsCount))
					.foregroundColor(color)
					.font(.system(size: 15, weight: .bold))
			}
		}
		.frame(minWidth: 44, minHeight: 44)
		.buttonStyle(.borderless)
	}
}
