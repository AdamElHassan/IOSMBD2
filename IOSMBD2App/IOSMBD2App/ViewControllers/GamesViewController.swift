//
//  GroupViewController.swift
//  SocialApp
//
//  Created by Adam el Hassan on 28/02/2019.
//  Copyright © 2019 Adam el Hassan. All rights reserved.
//

import UIKit
import MapKit

class GamesViewController: UITableViewController {
    
    private var apiGamesController: ApiGamesController!
    private var emptyList : Bool = true
    @IBOutlet var table: UITableView!
    var content: [GameData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiGamesController = ApiGamesController()
        content = []
        getGames()        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(content.count == 0){
            emptyList = true
            return 1
        }
        emptyList = false
        return content.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        
        if(!emptyList){
            let game = content[indexPath.row]
            cell.textLabel?.text = String(game._id.suffix(4))
            cell.imageView?.layer.borderWidth = 1.0
            cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.width)!/2;
            cell.imageView?.layer.masksToBounds = true;
            cell.imageView?.isHidden = false
            cell.isUserInteractionEnabled = true
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.detailTextLabel?.text =  "Users: " + String(game.users.count)
        }else{
            cell.textLabel?.text = "Loading games"
            cell.detailTextLabel?.text = ""
            cell.imageView?.isHidden = true
            cell.isUserInteractionEnabled = false
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getGames(){
        self.apiGamesController.getGames() { games in
            if (games != nil) {
                self.content = games?.games
            }else{
                
            }
            self.do_table_refresh()
        }
    }
    
    func do_table_refresh() {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let groupDetail = segue.destination as? GroupDetailViewController{
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let group = content[indexPath.section][indexPath.row]
//                groupDetail.group = group
//                groupDetail.groupViewController = self
//            }
//        }
//    }
    
}

