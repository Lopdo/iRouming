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
	let htmlMessage: NSAttributedString
	let registered: Bool
	let threadId: Int
	let date: Date

	var id: Double {
		return date.timeIntervalSince1970
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		title = try container.decode(String.self, forKey: .title)
		message = try container.decode(String.self, forKey: .message)
		nick = try container.decode(String.self, forKey: .nick)
		registered = try container.decode(String.self, forKey: .registered) == "1"
		threadId = Int(try container.decode(String.self, forKey: .threadId)) ?? -1
		date = Date(timeIntervalSince1970: Double(try container.decode(String.self, forKey: .date)) ?? 0)

		let tmpString = message.replacingOccurrences(of: "[i]", with: "<i>")
								.replacingOccurrences(of: "[/i]", with: "</i>")
								.replacingOccurrences(of: "[b]", with: "</b>")
								.replacingOccurrences(of: "[/b]", with: "</b>")
								.replacingOccurrences(of: "\n", with: "<br />")

		let mutableMessage = try NSMutableAttributedString(data: tmpString.data(using: .unicode)!,
															   options: [.documentType : NSAttributedString.DocumentType.html],
															   documentAttributes: nil)

		mutableMessage.beginEditing()
		mutableMessage.enumerateAttribute(.font, in: NSMakeRange(0, mutableMessage.length), options: []) { (value, range, stop) in
			if let font = value as? UIFont {
				/*var newFont: UIFont

				if oldFont.fontName.rangeOfString("italic", options: .CaseInsensitiveSearch, range: nil, locale: nil) != nil {
					newFont = UIFont(name: "Titillium-ThinItalic", size:13)!
				} else {
					newFont = UIFont(name: "Titillium-Thin", size:13)!
				}
				res.addAttribute(NSFontAttributeName, value: newFont, range: range)*/
			}
		}

		mutableMessage.endEditing()
		mutableMessage.addAttribute(.foregroundColor, value: UIColor.white, range: NSMakeRange(0, mutableMessage.length))

		htmlMessage = mutableMessage
	}
}

extension ForumPost: Identifiable { }
