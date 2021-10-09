//
//  CommentsDataManager.swift
//  iRouming
//
//  Created by Lope on 26/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import Foundation

struct CommentsDataManager {

	func loadComments(objectId: Int) async -> [Comment] {

		do {
			let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.rouming.cz/roumingXMLNew.php?action=comments&json=1&object=\(objectId)")!)
			return try JSONDecoder().decode([Comment].self, from: data)
		} catch {
			print(error)
			return []
		}
		
	}

}
