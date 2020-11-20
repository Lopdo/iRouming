//
//  URLSession+Result.swift
//  iRouming
//
//  Created by Lope on 20/11/2020.
//  Copyright © 2020 Lost Bytes. All rights reserved.
//

import Foundation

extension URLSession {
	func dataTask<T: Decodable>(with urlString: String, result: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {

		guard let url = URL(string: urlString) else {
			fatalError("Invalid URL: \(urlString)")
		}

		return dataTask(with: url) { (data, response, error) in
			if let error = error {
				result(.failure(error))
				return
			}
			guard let _ = response, let data = data else {
				let error = NSError(domain: "error", code: 0, userInfo: nil)
				result(.failure(error))
				return
			}
			do {
				let values = try JSONDecoder().decode(T.self, from: data)
				result(.success(values))
			} catch {
				print(error)
				result(.failure(error))
			}
		}
	}
}
