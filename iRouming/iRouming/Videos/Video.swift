//
//  Video.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

struct Video: Decodable, NewItemDisplayable {

	private enum CodingKeys: String, CodingKey {
		case date = "timestamp"
		case name
		case id = "object"
		case commentsCount = "comments"
		case rating = "rank"
		case url
	}

	let date: Date

	let name: String
	let id: Int
	let rating: Int
	let commentsCount: Int
	let youtubeId: String
	let urlThumbnail: String

	var isNew: Bool = false
	var isLastSeen: Bool = false
	var prefKey: String = "video"

	var headerData: HeaderData {
		return HeaderData(date: date, isNew: isNew, name: name, category: nil)
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

		let youtubeURLString = try container.decode(String.self, forKey: .url)
		if let equalSignIndex = youtubeURLString.lastIndex(of: "=") {
			youtubeId = String(youtubeURLString.suffix(from: youtubeURLString.index(after: equalSignIndex)))
		} else {
			throw ParseError.invalidYouTubeURL
		}

		urlThumbnail = "https://img.youtube.com/vi/\(youtubeId)/0.jpg"
		/*if let url = URL(string: "https://img.youtube.com/vi/\(youtubeId)/0.jpg") {
			thumbnailURL = url
		} else {
			throw ParseError.invalidYouTubeURL
		}*/

		initiateIsNew()
	}
}

extension Video: Identifiable { }

extension Video {

	init(name: String, rating: Int, commentsCount: Int, url: String, date: Date) {
		self.name = name
		self.rating = rating
		self.date = date
		self.commentsCount = commentsCount
		
		id = Int.random(in: 0..<Int.max)

		if let equalSignIndex = url.lastIndex(of: "=") {
			youtubeId = String(url.suffix(from: equalSignIndex))
		} else {
			fatalError()
		}

		urlThumbnail = "https://img.youtube.com/vi/\(youtubeId)/0.jpg"
	}
}
