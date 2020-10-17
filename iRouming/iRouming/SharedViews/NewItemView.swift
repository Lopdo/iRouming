//
//  NewItemView.swift
//  iRouming
//
//  Created by Lope on 26/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct NewItemView : View {
    var body: some View {
		Text("Nové")
			.padding(EdgeInsets(top: 1, leading: 3, bottom: 1, trailing: 3))
			.background(Color.brandYellow)
			.font(.system(size: 11, weight: .bold))
			.foregroundColor(.brandBlue)
			.cornerRadius(3.0)
    }
}

struct NewItemView_Previews : PreviewProvider {
    static var previews: some View {
		NewItemView()
			.previewLayout(.sizeThatFits)
    }
}
