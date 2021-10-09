//
//  JokesDataManager.swift
//  iRouming
//
//  Created by Lope on 12/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import Foundation

struct JokesDataManager {

	func loadJokes(page: Int) async -> [Joke] {

		do {
			let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.rouming.cz/roumingXMLNew.php?action=jokes&json=1&page=\(page)")!)
			let jokes = try JSONDecoder().decode([Joke].self, from: data)

			if let anyItem = jokes.first {
				let lastSeenDate = UserDefaults.standard.value(forKey: "lastSeen\(anyItem.prefKey)") as? Date ?? Date()
				var cJokes = jokes
				if let lastSeenItemIndex = cJokes.lastIndex(where: { $0.date > lastSeenDate }) {
					cJokes[lastSeenItemIndex].isLastSeen = true
				}

				UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")

				return cJokes
			} else {
				return jokes
			}
		} catch {
			print(error)
			return []
		}

	}

}
