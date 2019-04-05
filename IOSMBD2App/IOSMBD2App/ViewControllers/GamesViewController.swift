//
//  GroupViewController.swift
//  SocialApp
//
//  Created by Adam el Hassan on 28/02/2019.
//  Copyright © 2019 Adam el Hassan. All rights reserved.
//

import UIKit
import MapKit

class GroupViewController: UITableViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    private var apiGroupController: ApiGroupController!
    private var myUserGroups: [userGroup]! = []
    private var myGroups: [group]! = []
    private var noGroupsFoundMessage: [String]! = ["Eigen groepen aan het inladen", "Groepen aan het inladen"]
    @IBOutlet var table: UITableView!
    private var longitude: Double!
    private var latitude: Double!
    var content: [[group]]! = []
    var sections: [(sectionHeader: String, isEmpty: Bool)]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sections.insert((sectionHeader: "Groepen waar u lid van bent", isEmpty: true), at: 0)
        self.sections.insert((sectionHeader: "Groepen in de buurt", isEmpty: true), at: 1)
        self.content.insert(([]), at: 0)
        self.content.insert(([]), at: 1)
        self.apiGamesController = ApiGamesController()
        getGames()
        navigationController?.navigationBar.prefersLargeTitles = true;
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont(name: "Helvetica-bold", size: 16)
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(content[section].count == 0){
            return 1
        }
        return content[section].count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        if(sections[indexPath.section].isEmpty == false){
            let group = content[indexPath.section][indexPath.row]
            if(!group.name.isEmpty){
                cell.textLabel?.text = group.name
            }
            cell.imageView?.layer.borderWidth = 1.0
            cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.width)!/2;
            cell.imageView?.layer.masksToBounds = true;
            cell.imageView?.isHidden = false
            cell.isUserInteractionEnabled = true
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
            if(group.distance != nil){
                cell.detailTextLabel?.text = String (group.distance!) + " km"
            }else{
                cell.detailTextLabel?.text = ""
            }
        }else{
            cell.textLabel?.text = noGroupsFoundMessage[indexPath.section]
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
    
    func getMyGroups(){
        self.apiGroupController.getMyGroups() { userGroupData, errors in
            if (userGroupData != nil) {
                
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

