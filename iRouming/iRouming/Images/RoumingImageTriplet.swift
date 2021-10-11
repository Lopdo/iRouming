//
//  RoumingImageTriplet.swift
//  iRouming
//
//  Created by Lope on 11/10/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import Foundation

struct RoumingImageTriplet {
	let i1: RoumingImage
	let i2: RoumingImage?
	let i3: RoumingImage?

	init(from images: [RoumingImage]) {
		i1 = images[0]
		if images.count > 1 {
			i2 = images[1]
		} else  {
			i2 = nil
		}
		if images.count > 2 {
			i3 = images[2]
		} else {
			i3 = nil
		}
	}

	var images: [RoumingImage] {
		get {
			var result: [RoumingImage] = [i1]
			if let i2 = i2 {
				result.append(i2)
			}
			if let i3 = i3 {
				result.append(i3)
			}
			return result
		}
	}
}

extension RoumingImageTriplet: Identifiable {
	var id: Int {
		return i1.id
	}
}
