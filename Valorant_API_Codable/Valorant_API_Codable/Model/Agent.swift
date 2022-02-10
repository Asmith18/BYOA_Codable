//
//  Agent.swift
//  Valorant_API_Codable
//
//  Created by adam smith on 2/9/22.
//

import Foundation

struct TopLevelDict: Decodable {
    let data: [AgentData]
}

struct AgentData: Decodable {
    let displayName: String
    let displayIcon: String?
    let role: AgentRole
    let abilities: [AgentAbilities]
    let description: String
}

struct AgentRole: Decodable {
    let displayName: String
    let displayIcon: String?
}

struct AgentAbilities: Decodable {
    let displayName: String
    let displayIcon: String?
}
