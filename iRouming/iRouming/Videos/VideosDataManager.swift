//
//  VideosDataManager.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

struct VideosDataManager {

	func loadVideos() async -> [Video] {

		do {
			let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.rouming.cz/roumingXMLNew.php?action=videos&json=1")!)
			let videos = try JSONDecoder().decode([Video].self, from: data)

			if let anyItem = videos.first {
				let lastSeenDate = UserDefaults.standard.value(forKey: "lastSeen\(anyItem.prefKey)") as? Date ?? Date()
				var cVideos = videos
				if let lastSeenItemIndex = cVideos.lastIndex(where: { $0.date > lastSeenDate }) {
					cVideos[lastSeenItemIndex].isLastSeen = true
				}

				UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")

				return cVideos
			} else {
				return videos
			}
		} catch {
			print(error)
			return []
		}
	}

}

