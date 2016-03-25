//
//  FruitController.swift
//  HCI_recipe
//
//  Created by allen woo on 2/21/16.
//  Copyright © 2016 Chimian Wu. All rights reserved.
//



import UIKit
import Foundation

class FruitController: UIViewController,UITableViewDataSource {
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
    }
    
    //Search Bar Related
    //var detailViewController:DetailedController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK:  Inititialization
    func loadSampleMeat() {
        // TODO: Bug to be fixed
        let protein_sub = ["protein_avocado","protein_noni", "protein_soursop"]
        let protein = IngridentTypes(type : "Protein Fruit", photo: UIImage(named: "Protein Fruit"), sub_names: protein_sub)!
        
        let acid_sub = [ "acidfruit_lemon","acidfruit_mangosteen","acidfruit_kiwi"]
        let acid = IngridentTypes(type : "Acid Fruit", photo: UIImage(named: "Acid Fruit"), sub_names: acid_sub)!

        let subacid_sub = ["subacid_apple","subacid_berry", "subacid_grape"]
        let subacid = IngridentTypes(type : "Subacid Fruit", photo: UIImage(named: "Subacid Fruit"), sub_names: subacid_sub)!

        allmeat += [protein,acid,subacid]
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
        // #warning Incomplete implementation, return the number of sections
        //return allmeat.count
        
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
        //let cur_meat = allmeat[indexPath.section]
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

extension FruitController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
