//
//  SearchAPI.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 31.12.2020.
//

import Foundation

enum SearchAPI: EndpointType {
    
    case search(term: String, mediaType: String, page: Int)
    
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
        case .search(let term, let mediaType, let page):
            return [URLQueryItem(name: "term", value: String(term)),
                    URLQueryItem(name: "media", value: String(mediaType)),
                    URLQueryItem(name: "offset", value: String(page)),
                    URLQueryItem(name: "limit", value: String(20))]
        }
    }
    
    var httpHeaders: [HTTPHeader] {
        switch self {
        default:
            return []
        }
    }
}
