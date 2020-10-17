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
		case threadId = "thread"
		case postsCount = "posts"
	}

	let title: String
	let threadId: Int
	let postsCount: Int

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		title = try container.decode(String.self, forKey: .title)
		threadId = Int(try container.decode(String.self, forKey: .threadId)) ?? -1
		postsCount = Int(try container.decode(String.self, forKey: .postsCount)) ?? -1
	}
}
