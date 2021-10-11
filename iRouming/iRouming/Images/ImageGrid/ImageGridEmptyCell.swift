//
//  ImageGridEmptyCell.swift
//  iRouming
//
//  Created by Lope on 11/10/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI

struct ImageGridEmptyCell: View {
    var body: some View {
		VStack(spacing: 0) {
			Color.clear
				.aspectRatio(1, contentMode: .fill)
			Color.clear
				.frame(height: 44)
		}
    }
}

/*struct ImageGridEmptyCell_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridEmptyCell()
    }
}*/
