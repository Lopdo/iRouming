//
//  Comment.swift
//  iRouming
//
//  Created by Lope on 26/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import Foundation

struct Comment: Decodable {

	private enum CodingKeys: String, CodingKey {
		case nick
		case registered
		case date = "timestamp"
		case message
	}

	let nick: String
	let registered: RegistrationStatus
	let date: Date
	let message: String

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

		nick = try container.decode(String.self, forKey: .nick)
		registered = try container.decode(RegistrationStatus.self, forKey: .registered)
		date = Date(timeIntervalSince1970: Double(try container.decode(String.self, forKey: .date)) ?? 0)

		message = try container
			.decode(String.self, forKey: .message)
			.replacingOccurrences(of: "[i]", with: "*")
			.replacingOccurrences(of: "[/i]", with: "*")
			.replacingOccurrences(of: "[b]", with: "**")
			.replacingOccurrences(of: "[/b]", with: "**")
	}
}

extension Comment: Identifiable { }

#if DEBUG
extension Comment {

	init(nick: String, registered: RegistrationStatus, date: Date, message: String) {
		self.nick = nick
		self.registered = registered
		self.date = date
		self.message = message
	}
}
#endif
