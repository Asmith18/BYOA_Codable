//
//  NetworkingController.swift
//  Valorant_API_Codable
//
//  Created by adam smith on 2/9/22.
//

import Foundation
import UIKit

class NetworkingController {
    
    private static let baseURLString = "https://valorant-api.com"
    
    private static let agentComponent = "/v1/agents"
    
    static func fetchAgent(with urlString: String, completion: @escaping (Result<AgentData, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let finalURL = baseURL.appendingPathComponent(agentComponent)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            guard let agentData = data else {
                completion(.failure(.noData))
                return}
        
            do {
                let agent = try JSONDecoder().decode(AgentData.self, from: agentData)
                completion(.success(agent))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for agentIcon: String, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
        
        guard let imageURL = URL(string: agentIcon) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            guard let iconData = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let agentImage = UIImage(data: iconData) else {
                completion(.failure(.unableToDecode))
                return
            }
            completion(.success(agentImage))
        }
    }
}
