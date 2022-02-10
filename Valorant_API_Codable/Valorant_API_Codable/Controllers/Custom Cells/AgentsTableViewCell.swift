//
//  AgentsTableViewCell.swift
//  Valorant_API_Codable
//
//  Created by adam smith on 2/9/22.
//

import UIKit

class AgentsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var agentImageView: UIImageView!
    @IBOutlet weak var agentAbilityImageView: UIImageView!
    @IBOutlet weak var agentNameTextLabel: UILabel!
    @IBOutlet weak var agentRoleTextLabel: UILabel!
    
    
    func updateViews(agent: AgentData) {
        
        self.agentNameTextLabel.text = agent.displayName
        self.agentRoleTextLabel.text = agent.role.displayName
        fetchImage(for: agent)
        
        
    }
    
    func fetchImage(for agent: AgentData) {
        guard let agentDisplayIcon = agent.displayIcon else { return }
        NetworkingController.fetchImage(for: agentDisplayIcon) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.agentImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
        guard let abilitiesDisplayIcon = agent.role.displayIcon else { return }
        NetworkingController.fetchImage(for: abilitiesDisplayIcon) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.agentAbilityImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

