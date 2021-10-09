//
//  RegistrationStatusView.swift
//  iRouming
//
//  Created by Lope on 17/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI

struct RegistrationStatusView: View {

	let status: RegistrationStatus
	
    var body: some View {
		if status == .none {
			EmptyView()
		} else {
			Text(String("R"))
				.padding(EdgeInsets(top: 1, leading: 4, bottom: 1, trailing: 4))
				.background(status.bgColor)
				.font(.system(size: 11, weight: .bold))
				.foregroundColor(status.textColor)
				.cornerRadius(3.0)
		}
    }
}

fileprivate extension RegistrationStatus {

	var textColor: Color {
		if self == .registered {
			return .brandBlue
		} else if self == .roumen {
			return .brandYellow
		} else {
			return .clear
		}
	}

	var bgColor: Color {
		if self == .registered {
			return .brandYellow
		} else if self == .roumen {
			return Color("roumenBg")
		} else {
			return .clear
		}
	}
}

struct RegisteredUserView_Previews: PreviewProvider {
    static var previews: some View {
		HStack {
			RegistrationStatusView(status: .none)
			RegistrationStatusView(status: .registered)
			RegistrationStatusView(status: .roumen)
		}.previewLayout(.sizeThatFits)

		HStack {
			RegistrationStatusView(status: .none)
			RegistrationStatusView(status: .registered)
			RegistrationStatusView(status: .roumen)
		}
		.previewLayout(.sizeThatFits)
		.preferredColorScheme(.dark)

    }
}
