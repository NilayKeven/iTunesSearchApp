//
//  SearchAPI.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 31.12.2020.
//

import Foundation

enum SearchAPI: EndpointType {
    
    case search(term: String)
    
    var baseURL: URL {
        var urlComponent = URLComponents()
        urlComponent.host = Constants.baseHost
        urlComponent.scheme = Constants.scheme
        urlComponent.path = path
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else { return URL.init(string: "")!}
        return url
    }
    
    var path: String {
        switch self {

        case .search:
            return "/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let term):
            return [URLQueryItem(name: "term", value: String(term))]
        }
    }
    
    var httpHeaders: [HTTPHeader] {
        switch self {
        default:
            return []
        }
    }
}
