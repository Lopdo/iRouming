//
//  UIColor+Hex.swift
//  iRouming
//
//  Created by Lope on 04/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import UIKit

extension UIColor {

	public convenience init(hex: UInt32, useAlpha alphaChannel: Bool = false) {
		let mask: Int64 = 0xFF

		let r = Int64(hex >> (alphaChannel ? 24 : 16)) & mask
		let g = Int64(hex >> (alphaChannel ? 16 : 8)) & mask
		let b = Int64(hex >> (alphaChannel ? 8 : 0)) & mask
		let a = alphaChannel ? Int64(hex) & mask : 255

		let red   = CGFloat(r) / 255
		let green = CGFloat(g) / 255
		let blue  = CGFloat(b) / 255
		let alpha = CGFloat(a) / 255

		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	public final func toHex() -> UInt32 {
		func roundToHex(_ x: CGFloat) -> UInt32 {
			return UInt32(roundf(Float(x) * 255.0))
		}

		var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
		getRed(&r, green: &g, blue: &b, alpha: nil)

		let colorToInt = roundToHex(r) << 16 | roundToHex(g) << 8 | roundToHex(b)

		return colorToInt
	}

}
