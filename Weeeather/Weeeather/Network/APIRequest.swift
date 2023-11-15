//
//  APIRequest.swift
//  Weeeather
//
//  Created by taekki on 2023/11/14.
//

import Foundation

enum APIError: Error {
  case invalidURL
}

struct APIRequest {
  var baseURL: String = APIEnvironment.baseURL
  var path: String = ""
  var method: String = "GET"
  var query: [String: String]? = nil
  var header: [String: String]? = nil
  var body: Encodable? = nil
}

extension APIRequest {
  func makeURLRequest() throws -> URLRequest {
    let urlString = baseURL + path
    
    guard let url = URL(string: urlString) else {
      throw APIError.invalidURL
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method
    urlRequest.allHTTPHeaderFields = header
    
    let queryItems = query?.compactMap { URLQueryItem(name: $0.key, value: $0.value) } ?? []
    urlRequest.url?.append(queryItems: queryItems)
    
    if let body = body {
      urlRequest.httpBody = try JSONEncoder().encode(body)
    }
    return urlRequest
  }
}

