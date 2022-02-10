//
//  AgentTableViewController.swift
//  Valorant_API_Codable
//
//  Created by adam smith on 2/9/22.
//

import UIKit

class AgentTableViewController: UITableViewController {
    
    
    var data: [AgentData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingController.fetchAgent { result in
            switch result {
            case .success(let agentdata):
                self.data = agentdata.data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "agentCell", for: indexPath) as? AgentsTableViewCell else { return UITableViewCell() }
        
        let agent = data[indexPath.row]
        cell.updateViews(agent: agent)
        
        
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAgentVC" {
            if let destination = segue.destination as? AgentDetailViewController {
                guard let index = tableView.indexPathForSelectedRow else { return }
                let agent = data[index.row]
                destination.agentData = agent
            }
        }
    }
}
