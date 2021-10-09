//
//  ForumPost.swift
//  iRouming
//
//  Created by Lope on 13/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ForumPost: Decodable {

	private enum CodingKeys: String, CodingKey {
		case nick
		case registered
		case threadId = "thread"
		case date = "timestamp"
		case title = "description"
		case message
	}

	let nick: String
	let title: String
	let message: String
	let registered: RegistrationStatus
	let threadId: Int
	let date: Date

	var markdownMessage: AttributedString {
		get {
			do {
				return try AttributedString(markdown: message)
			} catch {
				print("Error parsing Markdown for string \(self): \(error)")
				return AttributedString(message)
			}
		}
	}
	
	var id: Double {
		return date.timeIntervalSince1970
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		title = try container.decode(String.self, forKey: .title)
		nick = try container.decode(String.self, forKey: .nick)
		registered = try container.decode(RegistrationStatus.self, forKey: .registered)
		threadId = Int(try container.decode(String.self, forKey: .threadId)) ?? -1
		date = Date(timeIntervalSince1970: Double(try container.decode(String.self, forKey: .date)) ?? 0)
		message = try container
			.decode(String.self, forKey: .message)
			.replacingOccurrences(of: "[i]", with: "*")
			.replacingOccurrences(of: "[/i]", with: "*")
			.replacingOccurrences(of: "[b]", with: "**")
			.replacingOccurrences(of: "[/b]", with: "**")
	}
}

extension ForumPost: Identifiable { }

#if DEBUG
extension ForumPost {

	init(title: String, nick: String, registered: RegistrationStatus, date: Date, message: String) {
		self.title = title
		self.nick = nick
		self.registered = registered
		self.date = date
		self.message = message

		threadId = -1
	}
}
#endif
