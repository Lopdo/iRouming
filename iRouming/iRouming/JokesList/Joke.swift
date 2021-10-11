//
//  Joke.swift
//  iRouming
//
//  Created by Lope on 12/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct Joke: Decodable, NewItemDisplayable {

	private enum CodingKeys: String, CodingKey {
		case text
		case category = "typeName"
		case name
		case id
		case rating = "rank"
		case date = "timestamp"
	}

	let text: String
	let category: String
	let date: Date
	
	let name: String
	let id: Int
	let rating: Int

	var isNew: Bool = false
	var isLastSeen: Bool = false
	var prefKey: String = "joke"

	var headerData: HeaderData {
		return HeaderData(date: date, isNew: isNew, name: name, category: category)
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

		let dateTimestamp = Double(try container.decode(String.self, forKey: .date)) ?? 0
		date = Date(timeIntervalSince1970: dateTimestamp)

		text = try container.decode(String.self, forKey: .text)
		category = try container.decode(String.self, forKey: .category)

		initiateIsNew()
	}
}

extension Joke: Identifiable { }

extension Joke {

	init(name: String, rating: Int, text: String, category: String, isLastSeen: Bool = false) {
		self.name = name
		self.rating = rating
		self.text = text
		self.category = category
		self.date = Date()

		id = Int.random(in: 0..<Int.max)

		self.isLastSeen = isLastSeen
	}
}
