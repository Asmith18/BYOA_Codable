//
//  AbilitiesTableViewCell.swift
//  Valorant_API_Codable
//
//  Created by adam smith on 2/9/22.
//

import UIKit

class AbilitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var agentAbilityNameTextLabel: UILabel!
    @IBOutlet weak var agentAbilityImageView: UIImageView!
    
    func updateViews(ability: AgentAbilities) {
        
        agentAbilityNameTextLabel.text = ability.displayName
    }
    
    func fetchImage(for ability: AgentAbilities) {
        
        guard let abilityDisplayIcon = ability.displayIcon else { return }
        NetworkingController.fetchImage(for: abilityDisplayIcon) { result in
            switch result {
            case .success(let agentIcon):
                DispatchQueue.main.async {
                    self.agentAbilityImageView.image = agentIcon
                }
            case .failure(let error):
                print(error)
        }
        }
    }
}
