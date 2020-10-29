//
//  ImagesDataManager.swift
//  iRouming
//
//  Created by Lope on 21/06/2019.
//  Copyright © 2019 Lost Bytes. All rights reserved.
//

import Alamofire

struct ImagesDataManager {

	func loadImages(success: @escaping ([RoumingImage]) -> ()) {

		AF.request("http://kecy.roumen.cz/roumingXMLNew.php?json=1").responseDecodable { (response: DataResponse<[RoumingImage], AFError>)  in
			//print("Request: \(String(describing: response.request))")   // original url request
			//print("Response: \(String(describing: response.response))") // http url response
			//print("Result: \(response.result)")                         // response serialization result

			switch response.result {
			case .success(let images):

				var varItems = images
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
