//
//  AbilitiesTableViewCell.swift
//  Valorant_API_Codable
//
//  Created by adam smith on 2/9/22.
//

import UIKit

class AbilitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var agentAbilityTextLabel: UILabel!
    @IBOutlet weak var agentAbilityIconImageView: UIImageView!
    

    func updateViews(agent: AgentAbilities) {
        
        agentAbilityTextLabel.text = agent.displayName
    }
}
