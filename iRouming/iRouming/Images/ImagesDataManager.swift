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

		let task = URLSession.shared.dataTask(with: "http://kecy.roumen.cz/roumingXMLNew.php?json=1") { (result: Result<[RoumingImage], Error>) in
			switch result {
			case .success(let images):
				success(images)

				if let anyItem = images.first {
					UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")
				}
			case .failure(let error):
				print(error)
			}
		}

		task.resume()
	}

}
