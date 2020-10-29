//
//  ImageEntity.swift
//  iRouming
//
//  Created by Lope on 21/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

enum ParseError: Error {
	case typeMismatch
	case invalidYouTubeURL
}

struct RoumingImage: Decodable, NewItemDisplayable {

	private enum CodingKeys: String, CodingKey {
		case name = "nameReadable"
		case id = "object"
		case commentsCount = "comments"
		case urlImage = "url"
		case urlThumbnail = "thumb"
		case likes
		case dislikes
		case date = "timestamp"
	}

	let name: String
	let id: Int
	let commentsCount: Int
	let urlImage: String
	let urlThumbnail: String
	let likes: Int
	let dislikes: Int
	let date: Date

	var isNew: Bool = false
	var isLastSeen: Bool = false
	var prefKey: String = "image"

	var headerData: HeaderData {
		return HeaderData(date: date, isNew: isNew, name: name, category: nil)
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		name = try container.decode(String.self, forKey: .name)
		if  let id = Int(try container.decode(String.self, forKey: .id)),
			let commentsCount = Int(try container.decode(String.self, forKey: .commentsCount)),
			let likes = Int(try container.decode(String.self, forKey: .likes)),
			let dislikes = Int(try container.decode(String.self, forKey: .dislikes))
		{
			self.id = id
			self.commentsCount = commentsCount
			self.likes = likes
			self.dislikes = dislikes
		} else {
			throw ParseError.typeMismatch
		}

		urlImage = try container.decode(String.self, forKey: .urlImage)
		urlThumbnail = try container.decode(String.self, forKey: .urlThumbnail)

		let dateTimestamp = Double(try container.decode(String.self, forKey: .date)) ?? 0
		date = Date(timeIntervalSince1970: dateTimestamp)

		initiateIsNew()
	}
}

extension RoumingImage: Identifiable { }

extension RoumingImage {

	init(name: String, commentsCount: Int, likes: Int, dislikes: Int, date: Date = Date()) {
		self.name = name
		self.commentsCount = commentsCount
		self.likes = likes
		self.dislikes = dislikes
		self.date = date

		id = Int.random(in: 0..<Int.max)
		urlImage = ""
		urlThumbnail = ""

	}
}
