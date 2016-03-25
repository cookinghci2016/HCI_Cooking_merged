//
//  MeatController.swift
//  HCI_recipe
//
//  Created by allen woo on 2/22/16.
//  Copyright © 2016 Chimian Wu. All rights reserved.
//

import UIKit
import Foundation

class MeatController: UIViewController,UITableViewDataSource {
    var allmeat = [IngridentTypes]()
    
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
   
    
    //searchBarRelated
    var filteredMeat = [IngridentTypes]()
    
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        filteredMeat = allmeat.filter{ meat in return meat.Ingtype.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView!.reloadData();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        loadSampleMeat()
        
        // Delet all elements during initialization of MeatController
    }
    
    //Search Bar Related
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK:  Inititialization
    func loadSampleMeat() {
        let beef_sub = ["beef_chuck", "beef_loin", "beef_rib","beef_round", "beef_shank"]
        let beef = IngridentTypes(type : "Beef", photo: UIImage(named: "Beef"), sub_names: beef_sub)!
        
        let chick_sub = ["chicken_breast", "chicken_cutlets", "chicken_tender","chicken_wings"]
        let chick = IngridentTypes(type : "Chicken", photo: UIImage(named: "Chicken"), sub_names: chick_sub)!
        
        let pork_sub = ["pork_breast", "pork_leg", "pork_loin","pork_rib", "pork_shoulder"]
        let pork = IngridentTypes(type : "Pork", photo: UIImage(named: "Pork"), sub_names: pork_sub)!
        
        let lamb_sub = ["lamb_flank", "lamb_leg", "lamb_loin","lamb_rib", "lamb_shoulder"]
        let lamb = IngridentTypes(type : "Lamb", photo: UIImage(named: "Lamb"), sub_names: lamb_sub)!
        
        let duck_sub = ["duck_backbone", "duck_breast", "duck_drumstick","duck_wings"]
        let duck = IngridentTypes(type : "Duck", photo: UIImage(named: "Duck"), sub_names: duck_sub)!
        
        allmeat += [beef, chick, pork, lamb, duck]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: Table view data source
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.active && searchController.searchBar.text != ""{
            return filteredMeat[section].Ingtype
        } else {
            return allmeat[section].Ingtype
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if searchController.active && searchController.searchBar.text != ""{
            return filteredMeat.count
        } else {
            return allmeat.count
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CategoryRow
        // Get current row and assign item numbers
        var cur_meat: IngridentTypes
        
        // Assign image array to UItable View Cell; Including the Image for ingredient, ox, pork, chicken and etc.
        if searchController.active && searchController.searchBar.text != ""{
            cur_meat = filteredMeat[indexPath.section]
            cell.num_sec = cur_meat.sub_imgs.count;
            cell.dic = filteredMeat[indexPath.section].sub_imgs
            cell.nm = filteredMeat[indexPath.section].sub_names
            cell.section_name = filteredMeat[indexPath.section].Ingtype

        } else {
            cur_meat = allmeat[indexPath.section]
            cell.num_sec = cur_meat.sub_imgs.count;
            cell.dic = allmeat[indexPath.section].sub_imgs
            cell.nm = allmeat[indexPath.section].sub_names
            cell.section_name = allmeat[indexPath.section].Ingtype
        }
        return cell
}
    
    // Close Key board when finish entering
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "completeSelection" {
            let DestViewController = segue.destinationViewController as! SearchByIngController
            var temp : [String] = []
            let shared_instance = Meat_Singleton.shared_instance
            for (mykey,_) in shared_instance.selected_meat {
                temp += shared_instance.selected_meat[mykey]!
            }
            DestViewController.all_selected_items += temp
        }
    }
}

extension MeatController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
