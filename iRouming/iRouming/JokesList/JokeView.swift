//
//  JokeView.swift
//  iRouming
//
//  Created by Lope on 12/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI

struct JokeView: View {

	let joke: Joke

	var body: some View {
		VStack(alignment: .leading, spacing: 0) {

			HeaderView(headerData: joke.headerData)

			Text(joke.text)
				.foregroundColor(.textBlack)
				.font(.system(size: 13))
				.lineLimit(nil)
				.padding(.top, 8)
			HStack {
				Spacer()
				Image("icn_rating_\(joke.rating)")
				Button(action: {
					//TODO
					print("tap copy")
				}, label: {
					Image("icn_copy")
						.frame(width: 24, height: 24, alignment: .center)
						.foregroundColor(.textGray)
				})
				.frame(width: 44, height: 44, alignment: .center)
			}.padding([.top, .bottom], 6)

		}
		.padding([.top, .leading, .trailing], 16)
		.background(Color.white)

	}
}

struct JokeView_Previews: PreviewProvider {
	static var previews: some View {
		JokeView(joke: Joke(name: "Podvodník nejvyšší. Podvodník nejvyšší. Podvodník nejvyšší.", rating: 2, text: "Viděl jsem dnes auto s nápisem:\nJSEM VETERINÁŘ, JEZDÍM JAKO ZVÍŘE.\n\nA pak mi došlo, kolik vidím denně na cestách gynekologů", category: "Zamyšlení"))
			.previewLayout(.sizeThatFits)
		JokeView(joke: Joke(name: "Podvodník nejvyšší.", rating: 2, text: "Viděl jsem dnes auto s nápisem:", category: "Zamyšlení"))
			.previewLayout(.sizeThatFits)
	}
}
