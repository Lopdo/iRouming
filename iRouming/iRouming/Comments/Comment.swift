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
	let registered: Bool
	let date: Date
	let message: String
	let htmlMessage: String

	var id: Double {
		return date.timeIntervalSince1970
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		nick = try container.decode(String.self, forKey: .nick)
		registered = try container.decode(String.self, forKey: .registered) == "1"
		date = Date(timeIntervalSince1970: Double(try container.decode(String.self, forKey: .date)) ?? 0)

		message = try container.decode(String.self, forKey: .message)
		htmlMessage = message.replacingOccurrences(of: "[i]", with: "<i>")
							 .replacingOccurrences(of: "[/i]", with: "</i>")
							 .replacingOccurrences(of: "[b]", with: "</b>")
							 .replacingOccurrences(of: "[/b]", with: "</b>")
							 .replacingOccurrences(of: "\n", with: "<br />")
	}
}

extension Comment: Identifiable { }

#if DEBUG
extension Comment {

	init(nick: String, registered: Bool, date: Date, message: String) {
		self.nick = nick
		self.registered = registered
		self.date = date
		self.message = message

		htmlMessage = message
	}
}
#endif
