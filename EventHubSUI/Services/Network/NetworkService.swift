//
//  NetworkService.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 09.09.2025.
//

import Foundation

final class NetworkService {
    
    private let session: URLSession

      init() {
          let configuration = URLSessionConfiguration.default
          configuration.timeoutIntervalForRequest = 30   // тайм-аут запроса
          configuration.timeoutIntervalForResource = 60 // тайм-аут на всю загрузку ресурса
          self.session = URLSession(configuration: configuration)
      }
    
    
    func fetch(from endpoint: Endpoint) async throws -> EventResponse {
        guard let urlRequest = NetworkRouter.createURLRequest(endpoint) else {
            throw NetworkError.invalidRequest
        }
        
        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(statusCode: 0)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        
        do {
            let result = try JSONDecoder().decode(EventResponse.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
