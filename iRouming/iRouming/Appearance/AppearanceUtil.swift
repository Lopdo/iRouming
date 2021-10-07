//
//  AppearanceUtil.swift
//  iRouming
//
//  Created by Lope on 17/09/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import UIKit
import SwiftUI

struct AppearanceUtil {

	static func setupBarsAppearance() {
		let appearance = UITabBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = UIColor(Color.brandBlue)

		let itemAppearance = UITabBarItemAppearance()
		itemAppearance.normal.iconColor = .white
		itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
		itemAppearance.selected.iconColor = UIColor(Color.brandYellow)
		itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.brandYellow)]

		appearance.stackedLayoutAppearance = itemAppearance

		UITabBar.appearance().standardAppearance = appearance
		UITabBar.appearance().scrollEdgeAppearance = appearance

		let navAppearance = UINavigationBarAppearance()
		navAppearance.configureWithOpaqueBackground()
		navAppearance.backgroundColor = UIColor(Color.brandBlue)
		navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,
											 .font: UIFont.boldSystemFont(ofSize: 20)]
		navAppearance.backgroundImage = AppearanceUtil.navbarImage()
		navAppearance.shadowColor = nil
		navAppearance.backgroundImageContentMode = .bottom
		UINavigationBar.appearance().standardAppearance = navAppearance
		UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
	}

	static func navbarImage() -> UIImage {

		let colors: [CGColor] = [UIColor(named: "brandBlueLight")!.cgColor,
								 UIColor(named: "brandBlue")!.cgColor]

		let colorSpace = CGColorSpaceCreateDeviceRGB()

		// now build a UIImage from the gradient
		let size = CGSize(width: 1000, height: 100)
		let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil)
		let center = CGPoint(x: size.width / 2.0, y: size.height - 30)
		//UIScreen.main.bounds.width
		let radius: CGFloat = 450 / 375 * UIScreen.main.bounds.width
		let renderer = UIGraphicsImageRenderer(size: size)
		return renderer.image { ctx in
			ctx.cgContext.setFillColor(UIColor(named: "brandBlue")!.cgColor)
			ctx.cgContext.fill(CGRect(origin: .zero, size: size))
			ctx.cgContext.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
		}

	}

	static func tabbarImage() -> UIImage {

		let colors: [CGColor] = [UIColor(Color.brandBlueLight).cgColor,
								 UIColor(Color.brandBlue).cgColor]

		let colorSpace = CGColorSpaceCreateDeviceRGB()

		// now build a UIImage from the gradient
		let size = CGSize(width: 1000, height: 100)
		let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil)
		let center = CGPoint(x: size.width / 2.0, y: -30)
		let radius: CGFloat = 450 / 375 * UIScreen.main.bounds.width
		let renderer = UIGraphicsImageRenderer(size: size)
		return renderer.image { ctx in
			ctx.cgContext.setFillColor(UIColor(Color.brandBlue).cgColor)
			ctx.cgContext.fill(CGRect(origin: .zero, size: size))
			ctx.cgContext.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
		}

	}
}
