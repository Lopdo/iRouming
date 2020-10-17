//
//  ImageService.swift
//  MovieSwift
//
//  Created by Thomas Ricouard on 07/06/2019.
//  Copyright © 2019 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import UIKit

class ImageService {
	static let shared = ImageService()
	private static let queue = DispatchQueue(label: "Image queue",
											 qos: DispatchQoS.userInitiated)

	//TODO: Build disk cache too.
	private var memCache: [String: UIImage] = [:]

	enum ImageError: Error {
		case decodingError
		case urlEncodingError
	}

	func purgeCache() {
		memCache.removeAll()
	}

	func syncImageFromCache(url: String) -> UIImage? {
		return memCache[url]
	}

	// TODO: Prefix memcache with poster size.
	func image(url urlString: String, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
		if let cachedImage = memCache[urlString] {
			completionHandler(.success(cachedImage))
			return
		}
		ImageService.queue.async {
			do {
				guard let url = URL(string: urlString) else {
					DispatchQueue.main.async {
						completionHandler(.failure(ImageError.urlEncodingError))
					}
					return
				}

				let data = try Data(contentsOf: url)
				let image = UIImage(data: data)
				DispatchQueue.main.async {
					if let image = image {
						self.memCache[urlString] = image
						completionHandler(.success(image))
					} else {
						completionHandler(.failure(ImageError.decodingError))
					}
				}
			} catch let error {
				DispatchQueue.main.async {
					completionHandler(.failure(error))
				}
			}
		}
	}
}
