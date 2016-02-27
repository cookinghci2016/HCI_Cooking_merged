//
//  MealTableViewController.swift
//  HCI_recipe
//
//  Created by Jie Tan on 2/16/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    var meals = [Recipe]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        loadSampleMeals()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadSampleMeals() {
        let photo1 = UIImage(named: "Chicken_Parmesan")!
        let meal1 = Recipe(name: "The BEST Chicken Parmesan", photo: photo1, description: "description for recipe 1")!
        
        let photo2 = UIImage(named: "GingerBeefBroccoli")!
        let meal2 = Recipe(name: "Ginger Beef Broccoli", photo: photo2, description: "")!
        
        let photo3 = UIImage(named: "HEARTY CHIPOTLE CHILI")!
        let meal3 = Recipe(name: "HEARTY CHIPOTLE CHILI", photo: photo3, description: "Ground beef, chipotle chile pepper and black beans star in this delightfully filling Hearty Chipotle Chili. ")!
        
        let photo4 = UIImage(named: "SweetSour_Chicken")!
        let meal4 = Recipe(name: "Sweet and Sour Chicken", photo: photo4, description: "description for recipe 4")!
        
        let photo5 = UIImage(named: "HOMESTYLE BEEF STEW")!
        let meal5 = Recipe(name: "HOMESTYLE BEEF STEW", photo: photo5, description: "")!

        
        meals += [meal3,meal1, meal2, meal4 , meal5]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.mealIamge.image = meal.photo
        cell.descriptionLabel.text = meal.description
        
        return cell

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
        let DestViewController = segue.destinationViewController as! RecipeViewController
        DestViewController.testRecipe = meals[indexPath.row]

    }
    

}
