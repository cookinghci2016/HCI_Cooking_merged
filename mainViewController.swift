//
//  mainViewController.swift
//  HCI_recipe
//
//  Created by Jie Tan on 2/23/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit

class mainViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate  {

    @IBOutlet var recipeCollection: UICollectionView!
    
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchIngredientButton: UIButton!
    @IBOutlet var searchNameButton: UIButton!
    var meals = [Recipe]()


    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeals()

        searchIngredientButton.hidden = true
        searchNameButton.hidden = true
        

        // Do any additional setup after loading the view.
    }
    
    func loadSampleMeals() {
        let photo1 = UIImage(named: "Chicken_Parmesan")!
        let meal1 = Recipe(name: "The BEST Chicken Parmesan", photo: photo1, description: "description for recipe 1")!
        
        let photo2 = UIImage(named: "BakedgeneralTSO_Chicken")!
        let meal2 = Recipe(name: "Baked general TSO Chicken", photo: photo2, description: "description for recipe 2")!
        
        let photo3 = UIImage(named: "OvenFried_Chicken")!
        let meal3 = Recipe(name: "Oven Fried Chicken", photo: photo3, description: "description for recipe 3")!
        
        let photo4 = UIImage(named: "SweetSour_Chicken")!
        let meal4 = Recipe(name: "Sweet and Sour Chicken", photo: photo4, description: "description for recipe 4")!
        
        let photo5 = UIImage(named: "GingerBeefBroccoli")!
        let meal5 = Recipe(name: "Ginger Beef Broccoli", photo: photo5, description: "")!

        let photo6 = UIImage(named: "HOMESTYLE BEEF STEW")!
        let meal6 = Recipe(name: "HOMESTYLE BEEF STEW", photo: photo6, description: "")!

        
        meals += [meal6,meal1, meal2, meal3, meal4, meal5]
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        searchIngredientButton.hidden = true
        searchNameButton.hidden = true
        searchButton.hidden = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("recipecell", forIndexPath: indexPath) as! recipeCollectionViewCell
        let meal = meals[indexPath.row]
        cell.recipeImage.image = meal.photo
        //cell.recipeName.text = recipeNames[indexPath.row]
        return cell
    }
    

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let recipe = meals[indexPath.row]
        self.performSegueWithIdentifier("presentRecipe",sender: recipe)
    }
    

    @IBAction func search(sender: AnyObject) {
        searchIngredientButton.hidden = false
        searchNameButton.hidden = false
        searchButton.hidden = true
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentRecipe"{
 
            let DestViewController = segue.destinationViewController as! RecipeViewController
            DestViewController.testRecipe = sender! as! Recipe

            
            
        }
    }
    
}
