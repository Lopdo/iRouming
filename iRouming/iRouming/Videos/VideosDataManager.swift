//
//  VideosDataManager.swift
//  iRouming
//
//  Created by Lope on 17/10/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Alamofire

struct VideosDataManager {

	func loadVideos(_ success: @escaping ([Video]) -> ()) {

		AF.request("http://kecy.roumen.cz/roumingXMLNew.php?action=videos&json=1").responseDecodable { (response: DataResponse<[Video], AFError>)  in
			switch response.result {
			case .success(let videos):
				success(videos)
			case .failure(let error):
				print(error)
			}
		}

	}

}

