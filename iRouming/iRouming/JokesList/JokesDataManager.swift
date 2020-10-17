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
				success(jokes)
			case .failure(let error):
				print(error)
			}
		}

	}

}
