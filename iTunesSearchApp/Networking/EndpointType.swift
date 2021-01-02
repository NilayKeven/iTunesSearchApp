//
//  EndpointType.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 31.12.2020.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var httpHeaders: [HTTPHeader] { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

extension EndpointType {
    
    typealias HTTPHeader = (value: String, forHTTPHeaderField: String)
    
    func retrieve<T: Codable>(completion: @escaping (_ response: (T?)) -> Void ) {
        
        var urlRequest = URLRequest(url: baseURL)
        
        for header in httpHeaders {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.forHTTPHeaderField)
        }
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let _ = error {
                Logger.log.error(error?.localizedDescription ?? "Client Error!")
                completion(nil)
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                Logger.log.error("Server Error!")
                completion(nil)
                return
            }
            
            if let data = data {
                let response = BaseResult(data: data)
                guard let decodedData = response.decode(T.self) else {
                    Logger.log.error("Decode Error!")
                    completion(nil)
                    return
                }
                Logger.log.info("Fetch data from \(baseURL)")
                completion(decodedData)
            }
        }
        urlSession.resume()
    }
}
