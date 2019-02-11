//
//  APIClient.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 10/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import Foundation

let BASEPATH = "https://www.googleapis.com/youtube/v3/"

class APIClient {

    static let shared = APIClient()

    func getRequest(for urlString: String, completion: @escaping ((_ data: Any?, _ response: URLResponse?, _ error: Error?)->())){

        let session = URLSession.shared
        let url = URL(string: urlString)

        session.dataTask(with: url!) { (data, response, error) in

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)

                completion(json, nil, nil)

            } catch {

            }

            }.resume()
    }
}
