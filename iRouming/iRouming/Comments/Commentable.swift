//
//  Commentable.swift
//  iRouming
//
//  Created by Lope on 27/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI
import  SDWebImageSwiftUI

protocol Commentable {
	var objectId: Int { get }
	var name: String { get }
	var urlThumbnail: String { get }
}

extension RoumingImage: Commentable {
	var objectId: Int {
		id
	}
}

extension Video: Commentable {
	var objectId: Int {
		id
	}
}

extension Gif: Commentable {
	var objectId: Int {
		id
	}
}
