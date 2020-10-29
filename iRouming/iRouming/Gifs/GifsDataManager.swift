//
//  GifsDataManager.swift
//  iRouming
//
//  Created by Lope on 24/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Alamofire

struct GifsDataManager {

	func loadGifs(_ success: @escaping ([Gif]) -> ()) {

		AF.request("http://kecy.roumen.cz/roumingXMLNew.php?action=gif&json=1").responseDecodable { (response: DataResponse<[Gif], AFError>)  in
			switch response.result {
			case .success(let gifs):
				var varItems = gifs
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

