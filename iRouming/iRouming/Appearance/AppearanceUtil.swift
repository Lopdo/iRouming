//
//  AppearanceUtil.swift
//  iRouming
//
//  Created by Lope on 17/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import UIKit

struct AppearanceUtil {

	static func setupBarsAppearance() {
		let appearance = UITabBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = UIColor(hex: 0x004A7F)

		let itemAppearance = UITabBarItemAppearance()
		itemAppearance.normal.iconColor = .white
		itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
		itemAppearance.selected.iconColor = UIColor(hex: 0xFEED00)
		itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(hex: 0xFEED00)]

		appearance.stackedLayoutAppearance = itemAppearance

		UITabBar.appearance().standardAppearance = appearance

		let navAppearance = UINavigationBarAppearance()
		navAppearance.configureWithOpaqueBackground()
		navAppearance.backgroundColor = UIColor(hex: 0x004A7F)
		navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,
											 .font: UIFont.boldSystemFont(ofSize: 20)]
		navAppearance.backgroundImage = AppearanceUtil.navbarImage()
		navAppearance.shadowColor = nil
		navAppearance.backgroundImageContentMode = .bottom
		UINavigationBar.appearance().standardAppearance = navAppearance
	}

	static func navbarImage() -> UIImage {

		let colors: [CGColor] = [UIColor(hex: 0x009EE0).cgColor,
								 UIColor(hex: 0x004A9F).cgColor]

		let colorSpace = CGColorSpaceCreateDeviceRGB()

		// now build a UIImage from the gradient
		let size = CGSize(width: 1000, height: 100)
		let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil)
		let center = CGPoint(x: size.width / 2.0, y: size.height - 30)
		let radius: CGFloat = 150
		let renderer = UIGraphicsImageRenderer(size: size)
		return renderer.image { ctx in
			ctx.cgContext.setFillColor(UIColor(hex: 0x004A9F).cgColor)
			ctx.cgContext.fill(CGRect(origin: .zero, size: size))
			ctx.cgContext.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
		}

	}

	static func tabbarImage() -> UIImage {

		let colors: [CGColor] = [UIColor(hex: 0x009EE0).cgColor,
								 UIColor(hex: 0x004A9F).cgColor]

		let colorSpace = CGColorSpaceCreateDeviceRGB()

		// now build a UIImage from the gradient
		let size = CGSize(width: 1000, height: 100)
		let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil)
		let center = CGPoint(x: size.width / 2.0, y: -30)
		let radius: CGFloat = 150
		let renderer = UIGraphicsImageRenderer(size: size)
		return renderer.image { ctx in
			ctx.cgContext.setFillColor(UIColor(hex: 0x004A9F).cgColor)
			ctx.cgContext.fill(CGRect(origin: .zero, size: size))
			ctx.cgContext.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
		}

	}
}
