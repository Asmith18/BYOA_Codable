//
//  AgentDetailViewController.swift
//  Valorant_API_Codable
//
//  Created by adam smith on 2/9/22.
//

import UIKit

class AgentDetailViewController: UIViewController {

    
    
    
    @IBOutlet weak var agentNameTextLabel: UILabel!
    @IBOutlet weak var agentIconImageView: UIImageView!
    @IBOutlet weak var agentDescriptionTextView: UITextView!
    @IBOutlet weak var agentAbilitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agentAbilitiesTableView.delegate = self
        agentAbilitiesTableView.dataSource = self
    }
    
    var agentAbilities: [AgentAbilities] = []
    
    var agentData: AgentData? {
        didSet {
            agentAbilities = agentData!.abilities
            updateViews()
        }
    }
    
    
    func updateViews() {
        guard let agentData = agentData else {
            return
        }
        
        guard let agentDisplayIcon = agentData.displayIcon else { return }
        NetworkingController.fetchImage(for: agentDisplayIcon) { result in
            switch result {
            case .success(let agentIcon):
                DispatchQueue.main.async {
                    self.agentNameTextLabel.text = agentData.displayName
                    self.agentDescriptionTextView.text = agentData.description
                    self.agentIconImageView.image = agentIcon
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
    
    
extension AgentDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Abilities"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agentAbilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "abilitiesCell", for: indexPath) as? AbilitiesTableViewCell else { return UITableViewCell() }
        
        let abilities = agentAbilities[indexPath.row]
        cell.updateViews(ability: abilities)
        
        
        return cell
    }

}

