//
//  GifsDataManager.swift
//  iRouming
//
//  Created by Lope on 24/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

struct GifsDataManager {

	func loadGifs() async -> [Gif] {

		do {
			let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.rouming.cz/roumingXMLNew.php?action=gif&json=1")!)
			let gifs = try JSONDecoder().decode([Gif].self, from: data)

			if let anyItem = gifs.first {
				let lastSeenDate = UserDefaults.standard.value(forKey: "lastSeen\(anyItem.prefKey)") as? Date ?? Date()
				var cGIFs = gifs
				if let lastSeenItemIndex = cGIFs.lastIndex(where: { $0.date > lastSeenDate }) {
					cGIFs[lastSeenItemIndex].isLastSeen = true
				}

				UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")

				return cGIFs
			} else {
				return gifs
			}
		} catch {
			print(error)
			return []
		}

	}

}

