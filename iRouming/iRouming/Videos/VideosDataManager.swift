//
//  VideosDataManager.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

struct VideosDataManager {

	func loadVideos(_ success: @escaping ([Video]) -> ()) {

		let task = URLSession.shared.dataTask(with: "https://www.rouming.cz/roumingXMLNew.php?action=videos&json=1") { (result: Result<[Video], Error>) in
			switch result {
			case .success(let videos):
				if let anyItem = videos.first {
					let lastSeenDate = UserDefaults.standard.value(forKey: "lastSeen\(anyItem.prefKey)") as? Date ?? Date()
					var cVideos = videos
					if let lastSeenItemIndex = cVideos.lastIndex(where: { $0.date > lastSeenDate }) {
						cVideos[lastSeenItemIndex].isLastSeen = true
					}

					success(cVideos)

					UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")
				} else {
					success(videos)
				}
			case .failure(let error):
				print(error)
			}
		}

		task.resume()
	}

}

