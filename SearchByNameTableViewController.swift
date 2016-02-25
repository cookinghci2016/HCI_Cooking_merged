//
//  SearchByNameTableViewController.swift
//  HCI_recipe
//
//  Created by Sudikoff Lab iMac on 2/24/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit

class SearchByNameTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var meals = [Recipe]()
    var filterdMeals = [Recipe]()
    
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        filterdMeals = meals.filter{ meal in return meal.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView!.reloadData();
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        loadSampleMeals()
    }
    
    let searchController = UISearchController(searchResultsController: nil)

    
    func loadSampleMeals() {
        let photo1 = UIImage(named: "Chicken_Parmesan")!
        let meal1 = Recipe(name: "Chicken Parmesan", photo: photo1, description: "The BEST Chicken Parmesan!")!
        
        let photo2 = UIImage(named: "BakedgeneralTSO_Chicken")!
        let meal2 = Recipe(name: "Baked General TSO Chicken", photo: photo2, description: "Baked general TSO Chicken")!
        
        let photo3 = UIImage(named: "OvenFried_Chicken")!
        let meal3 = Recipe(name: "Oven Fried Chicken", photo: photo3, description: "Oven Fried Chicken!")!
        
        let photo4 = UIImage(named: "SweetSour_Chicken")!
        let meal4 = Recipe(name: "Sweet Sour Chicken", photo: photo4, description: "Sweet as LOVERS!")!
        
        meals += [meal1, meal2, meal3, meal4]
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.active && searchController.searchBar.text != ""{
            return filterdMeals.count
        } else {
            return meals.count
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecipeNameCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let meal:Recipe
        if searchController.active && searchController.searchBar.text != ""{
            meal = filterdMeals[indexPath.row]
        }else {
            meal = meals[indexPath.row]
        }
        cell.textLabel?.text = meal.name
        cell.detailTextLabel?.text = meal.description
        cell.imageView?.image = meal.photo
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        let DestViewController = segue.destinationViewController as! RecipeViewController
        if searchController.active && searchController.searchBar.text != ""{
            DestViewController.testRecipe = filterdMeals[indexPath.row]
        }else{
            DestViewController.testRecipe = meals[indexPath.row]
        }
        
    }
    
}

extension SearchByNameTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


