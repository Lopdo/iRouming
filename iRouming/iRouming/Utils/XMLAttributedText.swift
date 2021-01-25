//
//  AttributedText.swift
//
// https://stackoverflow.com/a/64626941/124649
//

import SwiftUI

struct AttributedTextBlock {
	let content: String
	let font: Font?
	let color: Color?
}

struct XMLAttributedText: View {
	var attributedText: NSAttributedString?
	var originalText: String
	private var descriptions: [AttributedTextBlock] = []

	init(htmlText: String, fontSize: CGFloat) {
		let sanitizedText = htmlText.replacingOccurrences(of: "\r\n", with: "\n")
									.replacingOccurrences(of: "<br>", with: "\n")
									.replacingOccurrences(of: "<br />", with: "\n")
									.replacingOccurrences(of: "<br/>", with: "\n")

		originalText = "<r>" + sanitizedText + "</r>"

		let attributes: [String: [NSAttributedString.Key: Any]] =
			["r": [.font: Font.system(size: fontSize)],
			 "b": [.font: Font.system(size: fontSize, weight: .bold)],
			 "i": [.font: Font.system(size: fontSize).italic()]]

		var taggedSubstrings = findTagPairs(in: originalText.copy() as! String)

		// All locations are relative to the substring, we need to transform them to global string location space
		updateLocations(in: &taggedSubstrings, offset: 0)

		descriptions = formatAndRemoveTags(for: taggedSubstrings.first!, tagAttributes: attributes).0.reversed()
	}

	var body: some View {
		descriptions.map { description in
			Text(description.content)
				.font(description.font)
				.foregroundColor(description.color)
		}.reduce(Text("")) { (result, text) in
			result + text
		}
	}

	private func findTagPairs(in substring: String) -> [TaggedSubstring] {
		var taggedSubstrings: [TaggedSubstring] = []

		let scanner = Scanner(string: substring)
		scanner.charactersToBeSkipped = nil

		while !scanner.isAtEnd {
			var tag: String? = nil
			var startTagIndex: Int!
			repeat {
				_ = scanner.scanUpToString("<")
				startTagIndex = scanner.scanLocation
				_ = scanner.scanString("<")
				tag = scanner.scanUpToString(">")
				_ = scanner.scanString(">")
			} while (tag == nil && !scanner.isAtEnd)

			if scanner.isAtEnd {
				break
			}

			let endTag = String(format: "</%@>", tag!)
			let tmpString = scanner.scanUpToString(endTag)

			if scanner.isAtEnd {
				break
			}

			if let newSubstring = tmpString?.copy() as? String {

				// if we scanned something between tags, looks for nested tags in that substring
				var taggedSubstring = TaggedSubstring(tag: tag!, startTagStartIndex: startTagIndex, endTagStartIndex: scanner.scanLocation)
				taggedSubstring.innerTags = findTagPairs(in: newSubstring)
				taggedSubstrings.append(taggedSubstring)

			}

			_ = scanner.scanString(endTag)
		}

		return taggedSubstrings
	}

	private func updateLocations(in taggedSubstrings: inout [TaggedSubstring], offset: Int) {
		for i in 0..<taggedSubstrings.count {
			taggedSubstrings[i].startTagStartIndex += offset
			taggedSubstrings[i].endTagStartIndex += offset

			updateLocations(in: &taggedSubstrings[i].innerTags, offset: taggedSubstrings[i].startTagStartIndex + taggedSubstrings[i].tag.count + 2)
		}
	}

	/// Recursively formats the original string (self) based on the tags and removes those tags from the self. Returns total number of characters removed from the string, including child tags
	/// - Parameter taggedSubstrings: list of tags to remove
	/// - Returns: Number of characters removed after applying the style, including children
	@discardableResult
	private mutating func formatAndRemoveTags(for taggedSubstring: TaggedSubstring, tagAttributes: [String: [NSAttributedString.Key: Any]]) -> ([AttributedTextBlock], Int) {

		let font = (tagAttributes[taggedSubstring.tag.lowercased()]?[.font] as? Font) ?? Font.system(size: 17)
		let color = (tagAttributes[taggedSubstring.tag.lowercased()]?[.foregroundColor] as? Color) ?? Color.textBlack

		var removedChars = 0
		// go though all tags in reverse order, starting at the last tag. That way we don't have to
		// update tag locations as we move forward
		var currentDescriptions: [AttributedTextBlock] = []
		var currentIndex = taggedSubstring.endTagStartIndex
		for child in taggedSubstring.innerTags.reversed() {
			if child.endTagStartIndex + child.tag.count + 3 < currentIndex {

				let newEndTagIndex = originalText.index(originalText.startIndex, offsetBy: currentIndex)
				let startIndex = originalText.index(originalText.startIndex, offsetBy: child.endTagStartIndex + 1 + taggedSubstring.tag.count + 2)
				let substring = String(originalText[startIndex..<newEndTagIndex])
				currentDescriptions.append(AttributedTextBlock(content: substring,
															   font: font,
															   color: color))
			}

			let (childDescriptions, removedCharsByChildren) = formatAndRemoveTags(for: child, tagAttributes: tagAttributes)
			removedChars += removedCharsByChildren
			currentDescriptions.append(contentsOf: childDescriptions)
			currentIndex = child.startTagStartIndex
		}

		if let firstChild = taggedSubstring.innerTags.first {
			if firstChild.startTagStartIndex > taggedSubstring.startTagStartIndex + taggedSubstring.tag.count + 2 {

				let newEndTagIndex = originalText.index(originalText.startIndex, offsetBy: firstChild.startTagStartIndex)
				let startIndex = originalText.index(originalText.startIndex, offsetBy: taggedSubstring.startTagStartIndex + taggedSubstring.tag.count + 2)
				let substring = String(originalText[startIndex..<newEndTagIndex])
				currentDescriptions.append(AttributedTextBlock(content: substring,
															   font: font,
															   color: color))
			}
		} else {
			let newEndTagIndex = originalText.index(originalText.startIndex, offsetBy: taggedSubstring.endTagStartIndex)
			let startIndex = originalText.index(originalText.startIndex, offsetBy: taggedSubstring.startTagStartIndex + taggedSubstring.tag.count + 2)
			let substring = String(originalText[startIndex..<newEndTagIndex])
			currentDescriptions.append(AttributedTextBlock(content: substring,
														   font: font,
														   color: color))
		}

		let replaceEndTagStart = originalText.index(originalText.startIndex, offsetBy: taggedSubstring.endTagStartIndex - removedChars)
		let replaceEndTagEnd = originalText.index(replaceEndTagStart, offsetBy: taggedSubstring.tag.count + 3)
		originalText = originalText.replacingCharacters(in: replaceEndTagStart..<replaceEndTagEnd,
														with: "")
		let replaceStartTagStart = originalText.index(originalText.startIndex, offsetBy: taggedSubstring.startTagStartIndex)
		let replaceStartTagEnd = originalText.index(replaceStartTagStart, offsetBy: taggedSubstring.tag.count + 2)
		originalText = originalText.replacingCharacters(in: replaceStartTagStart..<replaceStartTagEnd,
														with: "")

		removedChars += 2 * taggedSubstring.tag.count + 5

		return (currentDescriptions, removedChars)
	}

}

private struct TaggedSubstring {
	let tag: String
	var startTagStartIndex: Int
	var endTagStartIndex: Int
	var innerTags: [TaggedSubstring] = []
}

struct AttributedText_Previews: PreviewProvider {
	static var previews: some View {
		XMLAttributedText(htmlText: "Hello! <b>World</b>", fontSize: 14)
			.previewLayout(.sizeThatFits)
		XMLAttributedText(htmlText: "<i>Hello!</i> World", fontSize: 10)
			.previewLayout(.sizeThatFits)
		XMLAttributedText(htmlText: "<i>Hello!</i> <b>World</b>", fontSize: 10)
			.previewLayout(.sizeThatFits)
		XMLAttributedText(htmlText: "Hel<b>lo! Wor</b>ld", fontSize: 10)
			.previewLayout(.sizeThatFits)
		XMLAttributedText(htmlText: "Hello<br /><i>World!</i>", fontSize: 10)
			.previewLayout(.sizeThatFits)
	}
}
