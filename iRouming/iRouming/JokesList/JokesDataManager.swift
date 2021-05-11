//
//  JokesDataManager.swift
//  iRouming
//
//  Created by Lope on 12/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import Foundation

struct JokesDataManager {

	func loadJokes(page: Int, success: @escaping ([Joke]) -> ()) {

		let task = URLSession.shared.dataTask(with: "https://www.rouming.cz/roumingXMLNew.php?action=jokes&json=1&page=\(page)") { (result: Result<[Joke], Error>) in
			switch result {
			case .success(let jokes):
				if let anyItem = jokes.first {
					let lastSeenDate = UserDefaults.standard.value(forKey: "lastSeen\(anyItem.prefKey)") as? Date ?? Date()
					var cJokes = jokes
					if let lastSeenItemIndex = cJokes.lastIndex(where: { $0.date > lastSeenDate }) {
						cJokes[lastSeenItemIndex].isLastSeen = true
					}

					success(cJokes)

					UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")
				} else {
					success(jokes)
				}
			case .failure(let error):
				print(error)
			}
		}

		task.resume()

	}

}
