//
//  RatingView.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import SwiftUI

struct RatingView: View {

	let rating: Int

	var body: some View {
		Image("icn_rating_\(rating)")
	}
}
