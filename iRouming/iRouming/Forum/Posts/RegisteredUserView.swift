//
//  RegisteredUserView.swift
//  iRouming
//
//  Created by Lope on 17/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI

struct RegisteredUserView: View {
    var body: some View {
		Text(String("R"))
			.padding(EdgeInsets(top: 1, leading: 3, bottom: 1, trailing: 3))
			.background(Color.brandYellow)
			.font(.system(size: 11, weight: .bold))
			.foregroundColor(.brandBlue)
			.cornerRadius(3.0)
    }
}

struct RegisteredUserView_Previews: PreviewProvider {
    static var previews: some View {
        RegisteredUserView()
			.previewLayout(.sizeThatFits)
    }
}
