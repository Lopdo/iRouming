//
//  JokeView.swift
//  iRouming
//
//  Created by Lope on 12/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import Firebase
import ToastUI
import Lottie

struct JokeView: View {

	@State var presentingToast: Bool = false

	let joke: Joke

	var body: some View {
		VStack(alignment: .leading, spacing: 0) {

			HeaderView(headerData: joke.headerData)

			Text(joke.text)
				.foregroundColor(.textBlack)
				.font(.system(size: 13))
				.lineLimit(nil)
				.padding(.top, 8)
				.padding([.leading, .trailing], 16)

			HStack {
				Spacer()
				RatingView(rating: joke.rating)
				Button(action: {
					UIPasteboard.general.string = joke.text

					presentingToast = true

					Analytics.logEvent("copy_to_clipboard", parameters: nil)
				}, label: {
					Image("icn_copy")
						.frame(width: 24, height: 24, alignment: .center)
						.foregroundColor(.textGray)
				})
				.buttonStyle(.borderless)
				.frame(width: 44, height: 44, alignment: .center)
				.toast(isPresented: $presentingToast, dismissAfter: 2.0) {
					ToastView("Zkopírováno do schránky") {
						LottieView(name: "check", loopMode: .playOnce)
								.frame(width: 58, height: 58, alignment: .center)
					} background: {
						// empty BG
					}
					.toastViewStyle(RoamingToastViewStyle())
				}
			}
			.padding([.top, .bottom], 6)
			.padding([.leading, .trailing], 16)

			if joke.isLastSeen {
				LastSeenView(lastSeenDate: joke.lastSeenDate)
			}
		}
		.background(Color.backgroundCard)
		.listRowSeparator(.hidden)
		.listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
		.listRowBackground(Color.background)
	}
}

struct JokeView_Previews: PreviewProvider {
	static var previews: some View {
		JokeView(joke: Joke(name: "Podvodník nejvyšší. Podvodník nejvyšší. Podvodník nejvyšší.", rating: 2, text: "Viděl jsem dnes auto s nápisem:\nJSEM VETERINÁŘ, JEZDÍM JAKO ZVÍŘE.\n\nA pak mi došlo, kolik vidím denně na cestách gynekologů", category: "Zamyšlení"))
			.previewLayout(.sizeThatFits)
		JokeView(joke: Joke(name: "Podvodník nejvyšší.", rating: 2, text: "Viděl jsem dnes auto s nápisem:", category: "Zamyšlení"))
			.previewLayout(.sizeThatFits)
		JokeView(joke: Joke(name: "Podvodník nejvyšší.", rating: 2, text: "Viděl jsem dnes auto s nápisem:", category: "Zamyšlení", isLastSeen: true))
			.previewLayout(.sizeThatFits)
	}
}
