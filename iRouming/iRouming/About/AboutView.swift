//
//  AboutView.swift
//  iRouming
//
//  Created by Lope on 27/01/2021.
//  Copyright © 2021 Lost Bytes. All rights reserved.
//

import SwiftUI
import Firebase

struct AboutView: View {

	@Environment(\.presentationMode) var presentationMode

	var body: some View {
		VStack {
			ZStack {

				Text("Vítejte na Roumingu")
					.font(.system(size: 17, weight: .bold))
					.foregroundColor(Color.textBlack)

				HStack {
					Spacer()

					Button(action: {
						presentationMode.wrappedValue.dismiss()
					}, label: {
						Image("icn_thread_close")
							.padding(12)
					})
				}.padding(.trailing, -20)
			}

			Text("Serveru plném zábavných a zajímavých obrázků videí a vtipů. Najdete zde materiál pro hodiny a hodiny online zábavy a legrace.")
				.multilineTextAlignment(.center)
				.font(.system(size: 13))
				.foregroundColor(Color.textBlack)
				.padding([.top, .bottom], 16)

			Text("iRouming je open source projekt. Bug reporty a feature requesty jsou vítané.")
				.multilineTextAlignment(.center)
				.font(.system(size: 13))
				.foregroundColor(Color.textBlack)
			Link("https://github.com/Lopdo/iRouming", destination: URL(string: "https://github.com/Lopdo/iRouming")!)
				.multilineTextAlignment(.center)
				.font(.system(size: 13, weight: .semibold))
				.foregroundColor(Color.brandBlue)
				.padding(2)

			Text("Tvůrci aplikace")
				.font(.system(size: 17, weight: .bold))
				.foregroundColor(Color.textBlack)
				.padding([.top], 48)

			HStack(spacing: 2) {
				Image("img_about_programming")
					.padding(12)

				VStack(alignment: .leading, spacing: 6) {
					Text("Naprogramoval")
						.font(.system(size: 13))
						.foregroundColor(Color.textGray)

					Text("Lopdo")
						.font(.system(size: 17, weight: .bold))
						.foregroundColor(Color.textBlack)
				}

				Spacer()
			}
			.background(Color.white)
			.cornerRadius(6)
			.padding([.top, .bottom], 24)

			HStack(spacing: 2) {
				Image("img_about_design")
					.padding(12)

				VStack(alignment: .leading, spacing: 2) {
					Text("Nadesignoval")
						.font(.system(size: 13))
						.foregroundColor(Color.textGray)
						.padding(.bottom, 4)

					Text("Marek Janjic")
						.font(.system(size: 17, weight: .bold))
						.foregroundColor(Color.textBlack)

					Link("www.justdesign.sk", destination: URL(string: "http://www.justdesign.sk")!)
						.multilineTextAlignment(.center)
						.font(.system(size: 11, weight: .semibold))
						.foregroundColor(Color.brandBlue)
				}

				Spacer()
			}
			.background(Color.white)
			.cornerRadius(6)


			Spacer()

			Text("v \(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "")")
				.font(.system(size: 11))
				.foregroundColor(Color.textGray)

		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding([.top, .leading, .trailing], 32)
		.padding(.bottom, 24)
		.background(Color.init(white: 238.0 / 255.0))
		.navigationBarTitle(Text("O aplikaci"))
		.onAppear {
			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "About"])
		}
	}

}


struct AboutView_Previews: PreviewProvider {
	static var previews: some View {
		AboutView()
	}
}
