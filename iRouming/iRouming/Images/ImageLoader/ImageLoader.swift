//
//  ImageData.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 09/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

final class ImageLoader: ObservableObject {
	let didChange = PassthroughSubject<UIImage?, Never>()

	let url: String

	init(url: String) {
		self.url = url
	}

	var image: UIImage? = nil {
		didSet {
			DispatchQueue.main.async {
				self.didChange.send(self.image)
			}
		}
	}

	/*var missing: Bool = false {
		didSet {
			DispatchQueue.main.async {
				self.didChange.send(nil)
			}
		}
	}*/

	func loadImage() {
		/*guard let url = url else {
			missing = true
			return
		}*/
		ImageService.shared.image(url: url) { (result) in
			do { self.image = try result.get() } catch { }
		}
	}
}
