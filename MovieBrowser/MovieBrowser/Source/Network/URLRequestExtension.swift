//
//  URLRequestExtension.swift
//  SampleProject
//
//  Created by Arun on 28/10/21.
//  Copyright © 2021 Arun. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

extension URLRequest {
    
    static func createRequestWith(url: String, method: HTTPMethod) -> URLRequest? {
        
        let url = ApiList.baseUrl + url
        let apiUrl = appendApiKeyTo(url)

        guard let formattedURL = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let finalURL = URL(string: formattedURL) else {
            return nil
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func appendApiKeyTo(_ url: String) -> String {
        
        var urlString = url
        if urlString.contains("?") {
            urlString.append("&api_key=\(Credentials.apiKey)")
        } else {
            urlString.append("?api_key=\(Credentials.apiKey)")
        }
        return urlString
    }
    
}
