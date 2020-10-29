//
//  JokesDataManager.swift
//  iRouming
//
//  Created by Lope on 12/07/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import Alamofire

struct JokesDataManager {

	func loadJokes(page: Int, success: @escaping ([Joke]) -> ()) {

		AF.request("http://kecy.roumen.cz/roumingXMLNew.php?action=jokes&json=1&page=\(page)").responseDecodable { (response: DataResponse<[Joke], AFError>)  in
			switch response.result {
			case .success(let jokes):
				var varItems = jokes
				if let index = varItems.lastIndex(where: { $0.isNew }) {
					varItems[index].isLastSeen = true
				}

				success(varItems)

				if let anyItem = varItems.first {
					UserDefaults.standard.setValue(Date(), forKey: "lastSeen\(anyItem.prefKey)")
				}


			case .failure(let error):
				print(error)
			}
		}

	}

}
