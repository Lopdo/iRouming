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

		let task = URLSession.shared.dataTask(with: "http://kecy.roumen.cz/roumingXMLNew.php?action=videos&json=1") { (result: Result<[Video], Error>) in
			switch result {
			case .success(let videos):
				success(videos)

				if let anyItem = videos.first {
					UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")
				}
			case .failure(let error):
				print(error)
			}
		}

		task.resume()
	}

}

