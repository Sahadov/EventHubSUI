//
//  NetworkRouter.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 09.09.2025.
//

import Foundation

enum NetworkRouter {
    static func createURLRequest(_ endpoint: Endpoint) -> URLRequest? {
        let baseURL = endpoint.baseURL
        
        return URLComponents(string: baseURL)
            .flatMap {
                var components = $0
                components.path = endpoint.path
                components.queryItems = endpoint.queryItems
                return components.url
            }
            .map { return URLRequest(url: $0) }
    }
}
