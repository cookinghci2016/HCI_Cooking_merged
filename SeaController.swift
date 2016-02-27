//
//  SeaController.swift
//  HCI_recipe
//
//  Created by allen woo on 2/21/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//



import UIKit
import Foundation

class SeaController: UIViewController,UITableViewDataSource {
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
        //        let shared_instance = Meat_Singleton.shared_instance
        //        shared_instance.selected_meat.removeAll()
        
    }
    
    //Search Bar Related
    //var detailViewController:DetailedController? = nil
    let searchController = UISearchController(searchResultsController: nil)
    
    // Iterate Through dictionary and get the value of selected items
    //    func updateCountingNumber() {
    //        var num:Int = 0
    //        for (_, items) in selectedIng {
    //            for _ in items {
    //                num = num + 1
    //            }
    //        }
    //        numLabel.text = String(num)
    //        }
    
    // MARK:  Inititialization
    func loadSampleMeat() {
        // TODO: Bug to be fixed
        let seasoning_sub = ["Chili","Garlic", "Pepper", "Paprika"]
        let seasoning = IngridentTypes(type : "Seasoning", photo: UIImage(named: "Seasoning"), sub_names: seasoning_sub)!
        
        //        let acid_sub = ["acidfruit_kiwi", "acidfruit_mangosteen"]
   //     let acid_sub = [ "acidfruit_lemon","acidfruit_mangosteen"]
     //   let acid = IngridentTypes(type : "Acid Fruit", photo: UIImage(named: "Acid Fruit"), sub_names: acid_sub)!
        
     //   let subacid_sub = ["subacid_apple","subacid_berry", "subacid_grape"]
       // let subacid = IngridentTypes(type : "Subacid Fruit", photo: UIImage(named: "Subacid Fruit"), sub_names: subacid_sub)!
        //
        //        let lamb_sub = ["lamb_flank", "lamb_leg", "lamb_loin","lamb_rib", "lamb_shoulder"]
        //        let lamb = IngridentTypes(type : "Lamb", photo: UIImage(named: "Lamb"), sub_names: lamb_sub)!
        //
        //        let duck_sub = ["duck_backbone", "duck_breast", "duck_drumstick","duck_wings"]
        //        let duck = IngridentTypes(type : "Duck", photo: UIImage(named: "Duck"), sub_names: duck_sub)!
        
        allmeat += [seasoning]
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
    
    //    @IBAction func SendtoCB(sender: AnyObject) {
    //        let shared_instance = Meat_Singleton.shared_instance
    //        var temp : [String] = []
    //        for (mykey,_) in shared_instance.selected_meat {
    //            temp += shared_instance.selected_meat[mykey]!
    //        }
    //        self.performSegueWithIdentifier("completeSelection", sender: temp)
    //    }
    
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
    //
    //    @IBAction func back(segue: UIStoryboardSegue) {
    //        self.navigationController?.popViewControllerAnimated(true)
    //    }
    
    
    //    // Failed: Center Section Name for each cell; Must have two sections
    //    func tablevIEW(tableView: UITableView, viewForHeaderInSection section: Int)-> UIView? {
    //        var title : UILabel = UILabel()
    //        title.text = "Hello"
    //        title.textColor = UIColor(red: 77.0/255.0, green: 98.0/255.0, blue: 130.0/255.0, alpha: 1.0)
    //        title.backgroundColor = UIColor(red: 225.0/255.0, green: 243.0/255.0, blue: 251.0/255.0, alpha: 1.0)
    //        title.font = UIFont.boldSystemFontOfSize(10)
    //        var constraint = NSLayoutConstraint.constraintsWithVisualFormat("H:[label]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["label": title])
    //        title.textAlignment = NSTextAlignment.Center
    //        title.addConstraints(constraint)
    //        return title
    //    }
    
    
    // Update Collected strings by trigging Row select Event;
    
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //            let cell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryRow
    //            self.selectedIng[cell.section_name] = cell.selectedIng_string
    //            print("Value Uploarded")
    //    }
    
    
    
    //Search Related
    
    //Search Related END
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

extension SeaController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
