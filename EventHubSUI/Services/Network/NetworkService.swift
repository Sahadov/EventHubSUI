//
//  NetworkService.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 09.09.2025.
//

import Foundation

final class NetworkService {
    func fetch(from endpoint: Endpoint) async throws -> Event {
        guard let urlRequest = NetworkRouter.createURLRequest(endpoint) else {
            throw NetworkError.invalidRequest
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(statusCode: 0)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        
        do {
            let result = try JSONDecoder().decode(Event.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
