//
//  NetworkManager.swift
//  SampleProject
//
//  Created by Arun on 28/10/21.
//  Copyright © 2021 Arun. All rights reserved.
//

import UIKit

struct ApiList {
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let searchMovie = "search/movie?query=%@"
    static let getMovieDetail = "movie/%d"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w%d"
}

struct Credentials {
    static let apiKey = "5885c445eab51c7004916b9c0313e2d3"
}


class NetworkManager: NSObject, URLSessionDelegate, NSURLConnectionDataDelegate {
    
    static let sharedManager = NetworkManager()
    
    func callWith<T: Decodable >(request: URLRequest, completion: @escaping (Result<T, Error>) -> (Void)) {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)

        let task = session.dataTask(with: request, completionHandler: { data, _, error -> Void in
            if let error = error {
                completion(.failure(error))
            } else {
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data),
                let dataObj = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                let detail = try? JSONDecoder().decode(T.self, from: dataObj) {
                    completion(.success(detail))
                }
            }
        })
        
        task.resume()
    }

}
