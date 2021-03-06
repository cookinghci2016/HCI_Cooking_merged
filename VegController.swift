//
//  VegController.swift
//  HCI_recipe
//
//  Created by allen woo on 2/21/16.
//  Copyright © 2016 Chimian Wu. All rights reserved.

        import UIKit
        import Foundation
        
class VegController: UIViewController,UITableViewDataSource {
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
            let searchController = UISearchController(searchResultsController: nil)
    
            // MARK:  Inititialization
            func loadSampleMeat() {
                let leafy_sub = ["leafy_cabbages","leafy_lettuces", "leafy_spinach"]
                let leafy = IngridentTypes(type : "Leafy", photo: UIImage(named: "Leafy"), sub_names: leafy_sub)!
                
          let root_sub = [ "root_sweetpotato","root_beet", "root_carrot"]
          let root = IngridentTypes(type : "Root", photo: UIImage(named:"Root"), sub_names: root_sub)!
                
            let fruitveg_sub = ["fruitveg_tomato","fruitveg_capsicum", "fruitveg_cucumber"]
            let fruitveg = IngridentTypes(type : "Fruit vegetable", photo: UIImage(named: "Fruit vegetable"), sub_names: fruitveg_sub)!
                allmeat += [leafy,root,fruitveg]
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
                    //            DestViewController.all_selected_items = sender! as! [String]
                    //            for (mykey,_) in shared_instance.selected_meat {
                    //                    DestViewController.all_selected_items.insert(item)
                    //            }
                    var temp : [String] = []
                    let shared_instance = Meat_Singleton.shared_instance
                    for (mykey,_) in shared_instance.selected_meat {
                        temp += shared_instance.selected_meat[mykey]!
                    }
                    DestViewController.all_selected_items += temp
                }
            }
    }
        extension VegController: UISearchResultsUpdating {
            func updateSearchResultsForSearchController(searchController: UISearchController) {
                filterContentForSearchText(searchController.searchBar.text!)
            }
}