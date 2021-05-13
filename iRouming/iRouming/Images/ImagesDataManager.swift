//
//  ImagesDataManager.swift
//  iRouming
//
//  Created by Lope on 21/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import Foundation

struct ImagesDataManager {

	func loadImages(success: @escaping ([RoumingImage]) -> ()) {

		let task = URLSession.shared.dataTask(with: "https://www.rouming.cz/roumingXMLNew.php?json=1") { (result: Result<[RoumingImage], Error>) in
			switch result {
			case .success(let images):

				if let anyItem = images.first {
					let lastSeenDate = UserDefaults.standard.value(forKey: "lastSeen\(anyItem.prefKey)") as? Date ?? Date()
					var cImages = images
					if let lastSeenItemIndex = cImages.lastIndex(where: { $0.date > lastSeenDate }), lastSeenItemIndex != 0 {
						cImages[lastSeenItemIndex].isLastSeen = true
					}

					success(cImages)

					UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")
				} else {
					success(images)
				}

			case .failure(let error):
				print(error)
			}
		}

		task.resume()
	}

}
