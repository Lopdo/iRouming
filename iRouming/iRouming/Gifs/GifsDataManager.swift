//
//  GifsDataManager.swift
//  iRouming
//
//  Created by Lope on 24/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

struct GifsDataManager {

	func loadGifs(_ success: @escaping ([Gif]) -> ()) {

		let task = URLSession.shared.dataTask(with: "https://www.rouming.cz/roumingXMLNew.php?action=gif&json=1") { (result: Result<[Gif], Error>) in
			switch result {
			case .success(let gifs):
				success(gifs)

				if let anyItem = gifs.first {
					UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")
				}
			case .failure(let error):
				print(error)
			}
		}

		task.resume()
	}

}

