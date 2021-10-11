//
//  JokesListView.swift
//  iRouming
//
//  Created by Lope on 12/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import SwiftUI
import Firebase

struct JokesListView: View {

	@StateObject var interactor = JokesInteractor()
	@State var showingDetail = false
	
	var body: some View {
		Group {
			if interactor.isLoading && interactor.jokes.count == 0 {
				LoadingView()
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			} else {
				List(interactor.jokes) { joke in
					JokeView(joke: joke)
					if interactor.jokes.last?.id == joke.id {
						LoadingView()
							.frame(height: 80, alignment: .center)
							.frame(maxWidth: .infinity)
							.onAppear {
								if !interactor.isLoading {
									Task {
										await interactor.loadNextPage()
									}
								}
							}
					}
				}
				.listStyle(.plain)
				.background(Color.background)
				.refreshable {
					await interactor.getJokes()
				}
			}
		}
		.navigationBarTitle(Text("Vtipník"), displayMode: .inline)
		.navigationBarItems(trailing:
								Button(action: {
									self.showingDetail.toggle()
								}) {
									Image("icn_navbar_info")
								}.sheet(isPresented: $showingDetail) {
									AboutView()
								}
		)
		.onAppear {
			Analytics.logEvent(AnalyticsEventScreenView,
							   parameters: [AnalyticsParameterScreenName: "JokesList"])
		}
	}

}

extension JokesListView {

	fileprivate init(jokes: [Joke]) {
		interactor.jokes = jokes
		interactor.isLoading = false
	}

}

struct JokesListView_Previews: PreviewProvider {
	static var previews: some View {
		JokesListView(jokes: [Joke(name: "Podvodník nejvyšší.", rating: 1, text: "Viděl jsem dnes auto s nápisem:\nJSEM VETERINÁŘ, JEZDÍM JAKO ZVÍŘE.\n\nA pak mi došlo, kolik vidím denně na cestách gynekologů", category: "Zamyšlení"),
							  Joke(name: "Podvodník nejvyšší. Podvodník nejvyšší.", rating: 2, text: "Viděl jsem dnes auto s nápisem:\nJSEM VETERINÁŘ, JEZDÍM JAKO ZVÍŘE.\n\nA pak mi došlo, kolik vidím denně na cestách gynekologů", category: "Zamyšlení"),
							  Joke(name: "Podvodník nejvyšší.Podvodník nejvyšší. Podvodník nejvyšší. Podvodník nejvyšší. Podvodník nejvyšší.", rating: 3, text: "Viděl jsem dnes auto s nápisem", category: "Zamyšlení"),
							  Joke(name: "Podvodník nejvyšší.", rating: 4, text: "Viděl jsem dnes auto s nápisem:\nJSEM VETERINÁŘ, JEZDÍM JAKO ZVÍŘE.\n\nA pak mi došlo, kolik vidím denně na cestách gynekologů", category: "Zamyšlení"),
							  Joke(name: "Podvodník nejvyšší.", rating: 5, text: "Viděl jsem dnes auto s nápisem:\nJSEM VETERINÁŘ, JEZDÍM JAKO ZVÍŘE.\n\nA pak mi došlo, kolik vidím denně na cestách gynekologů", category: "Zamyšlení")])
	}
}
