//
//  Gif.swift
//  iRouming
//
//  Created by Lope on 24/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

struct Gif: Decodable {

	private enum CodingKeys: String, CodingKey {
		case name
		case id = "object"
		case commentsCount = "comments"
		case urlImage = "url"
		case rating = "rank"
		case date = "timestamp"
	}

	let name: String
	let id: Int
	let commentsCount: Int
	let url: URL
	let rating: Int
	let date: Date

	var headerData: HeaderData {
		return HeaderData(date: date, isNew: true, name: name, category: nil)
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		name = try container.decode(String.self, forKey: .name)
		if  let id = Int(try container.decode(String.self, forKey: .id)),
			let rating = Int(try container.decode(String.self, forKey: .rating))
		{
			self.id = id
			self.rating = rating
		} else {
			throw ParseError.typeMismatch
		}

		commentsCount = Int(try container.decode(String.self, forKey: .commentsCount)) ?? 0

		let dateTimestamp = Double(try container.decode(String.self, forKey: .date)) ?? 0
		date = Date(timeIntervalSince1970: dateTimestamp)

		if let url = URL(string: try container.decode(String.self, forKey: .urlImage)) {
			self.url = url
		} else {
			throw ParseError.typeMismatch
		}
	}
}

extension Gif: Identifiable { }

extension Gif {

	init(name: String, commentsCount: Int, rating: Int, date: Date = Date()) {
		self.name = name
		self.commentsCount = commentsCount
		self.rating = rating
		self.date = date

		id = Int.random(in: 0..<Int.max)
		url = URL(string: "http://example.com")!
	}
}
