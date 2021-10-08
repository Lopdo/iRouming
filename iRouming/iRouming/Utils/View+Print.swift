//
//  View+Print.swift
//  iRouming
//
//  Created by Lope on 08/10/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI

#if DEBUG
extension View {
	func Print(_ vars: Any...) -> some View {
		for v in vars { print(v) }
		return EmptyView()
	}
}
#endif
