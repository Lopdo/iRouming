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
				success(gifs)
			case .failure(let error):
				print(error)
			}
		}

	}

}

