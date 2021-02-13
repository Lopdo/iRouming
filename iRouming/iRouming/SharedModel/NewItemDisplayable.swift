//
//  NewItemDisplayable.swift
//  iRouming
//
//  Created by Lope on 29/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

protocol NewItemDisplayable {
	var date: Date { get }
	var isNew: Bool { get set }
	var isLastSeen: Bool { get }

	var lastSeenDate: Date { get }
	var prefKey: String { get }
}

extension NewItemDisplayable {

	var lastSeenDate: Date {
		UserDefaults.standard.object(forKey: "lastSeen\(prefKey)") as? Date ?? Date()
	}

	mutating func initiateIsNew() {
		if let lastDate = UserDefaults.standard.object(forKey: "lastSeen\(prefKey)") as? Date {
			isNew = date.distance(to: lastDate) < 0
		} else {
			isNew = true
		}
	}

}
