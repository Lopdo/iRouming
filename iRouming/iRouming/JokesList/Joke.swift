//
//  Joke.swift
//  iRouming
//
//  Created by Lope on 12/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct Joke: Decodable {

	private enum CodingKeys: String, CodingKey {
		case text
		case category = "typeName"
		case name
		case id
		case rating = "rank"
	}

	let text: String
	let category: String
	//TODO: load from API once it is added
	let date: Date = Date()
	
	let name: String
	let id: Int
	let rating: Int

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

		text = try container.decode(String.self, forKey: .text)
		category = try container.decode(String.self, forKey: .category)
	}
}

extension Joke: Identifiable { }

extension Joke {

	init(name: String, rating: Int, text: String, category: String) {
		self.name = name
		self.rating = rating
		self.text = text
		self.category = category

		id = Int.random(in: 0..<Int.max)
	}
}
