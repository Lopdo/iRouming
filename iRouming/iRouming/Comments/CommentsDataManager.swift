//
//  CommentsDataManager.swift
//  iRouming
//
//  Created by Lope on 26/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import Foundation

struct CommentsDataManager {

	func loadComments(objectId: Int, success: @escaping ([Comment]) -> ()) {

		let task = URLSession.shared.dataTask(with: "https://www.rouming.cz/roumingXMLNew.php?action=comments&json=1&object=\(objectId)") { (result: Result<[Comment], Error>) in
			switch result {
			case .success(let coments):
				success(coments)
			case .failure(let error):
				print(error)
			}
		}

		task.resume()
	}

}
