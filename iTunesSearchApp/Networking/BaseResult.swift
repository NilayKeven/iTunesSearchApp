//
//  BaseResult.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 31.12.2020.
//

import Foundation

struct BaseResult {
    
    private var data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch {
            print(error)
            return nil
        }
    }
}
