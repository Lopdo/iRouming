//
//  ForumThread.swift
//  iRouming
//
//  Created by Lope on 13/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ForumThread: Decodable {

	private enum CodingKeys: String, CodingKey {
		case title = "description"
		case id = "thread"
		case postsCount = "posts"
	}

	let title: String
	let id: Int
	let postsCount: Int

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		title = try container.decode(String.self, forKey: .title)
		id = Int(try container.decode(String.self, forKey: .id)) ?? -1
		postsCount = Int(try container.decode(String.self, forKey: .postsCount)) ?? -1
	}
}

extension ForumThread: Identifiable { }

extension ForumThread {

	init(title: String, postsCount: Int) {
		self.title = title
		self.postsCount = postsCount

		id = Int.random(in: 0..<Int.max)
	}
}
