//
//  ImagesDataManager.swift
//  iRouming
//
//  Created by Lope on 21/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import Foundation

struct ImagesDataManager {

	func loadImages() async -> [RoumingImage] {

		do {
			let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.rouming.cz/roumingXMLNew.php?json=1")!)
			let images = try JSONDecoder().decode([RoumingImage].self, from: data)

			if let anyItem = images.first {
				let lastSeenDate = UserDefaults.standard.value(forKey: "lastSeen\(anyItem.prefKey)") as? Date ?? Date()
				var cImages = images
				if let lastSeenItemIndex = cImages.lastIndex(where: { $0.date > lastSeenDate }), lastSeenItemIndex != 0 {
					cImages[lastSeenItemIndex].isLastSeen = true
				}

				UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")

				return cImages
			} else {
				return images
			}

		} catch {
			print(error)
			return []
		}

	}

}
