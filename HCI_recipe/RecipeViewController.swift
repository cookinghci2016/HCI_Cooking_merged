//
//  RecipeViewController.swift
//  HCI_recipe
//
//  Created by Jie Tan on 2/15/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit


class RecipeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {


    @IBOutlet var ingredientView: UITableView!
    @IBOutlet var stepView: UITableView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var flavorLabel: UILabel!
    @IBOutlet var ingredientLabel: UILabel!
    @IBOutlet var stepLabel: UILabel!
    @IBOutlet weak var caloryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var anotherNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    var testRecipe = Recipe!()
    var thisRecipe = Recipe(name:"The BEST Chicken Parmesan",photo:UIImage(named: "Chicken_Parmesan")!, description: "")!
    var ingredients = ["mushrooms","sun-dried tomatoes","chicken breasts","basil","parsley","rosemary","thyme","garlic","olive oil","Serrano ham"]
    var dosages = ["1/4 cup","1/3 cup","2","1 bunch","1 bunch","1 sprig","1 sprig","1 clove","1/3 cup","4 slices"]
    var cookingtime = 30
    var flavor = "Sweet"
    var calorie = 300
    var stepTitle = ["Step 1","Step 2","Step3","Step4","Step5"]
    var stepDescription = ["Preheat the grill for 5 mins. Finely slice mushrooms. Drain sun-dried tomatoes and cut into strips.","With your fingers, carefully loosen the skin of the chicken breast and place some of the sliced mushrooms and sun-dried tomatoes underneath it.","For the pesto, pick basil, parsley, rosemary, and thyme leaves. Peel and crush garlic clove. Puree everything in a food processor with olive oil, salt and pepper.","Cover stuffed chicken breasts with pesto on both sides. Tightly wrap two slices of Serrano ham around each chicken breast.","Grill chicken and turn occasionally until the ham is crispy. Move the chicken onto indirect heat and finish cooking for 10 mins. Season again with salt and pepper and serve with a grilled corncob."]
    var stepPhoto = [UIImage(named: "process0")!,UIImage(named: "process1")!,UIImage(named: "process2")!,UIImage(named: "process3")!,UIImage(named: "process4")!]
    var stepTip = ["Tips for step1","","","Tips for step4",""]
    var tipHidden = [false,true,true,false,true]
    var stepReminder = ["mushrooms:1/4cup\nsun-dried tomatoes:\n1/3cup","Chicken breast:2","basil and parsely:\n1 bunch each\nrosemary and thyme:\n1sprig each","Serrano ham:\n4slices",""]
    var reminderHidden = [false,false,false,false,true]
    var stepTimer = [5,0,0,0,10]
    var timerHidden = [false,true,true,true,false]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ScrollView.contentSize.height = 2500
        
        nameLabel.text = testRecipe.name
        self.recipeImage.image = testRecipe.photo
        anotherNameLabel.text = testRecipe.name
        descriptionLabel.text = testRecipe.description
        
        timeLabel.numberOfLines = 0
        timeLabel.frame = CGRectMake(0, 0, 65,50)
        timeLabel.text = "Time\n\(cookingtime)mins"
        //timeLabel.layer.borderWidth = 0.5
        //timeLabel.layer.borderColor = UIColor.blackColor().CGColor
        flavorLabel.numberOfLines=0
        flavorLabel.frame = CGRectMake(0, 0, 65,50)
        flavorLabel.text = "Flavor\n"+flavor
        caloryLabel.numberOfLines=0
        caloryLabel.frame = CGRectMake(0, 0, 65,50)
        caloryLabel.text = "Calorie\n\(calorie)K"
        
        
    }
    var clicked = false
    @IBAction func likeit(sender: AnyObject) {
        if (clicked==false){
            likeButton.setImage(UIImage(named: "liked"), forState: UIControlState.Normal)
            clicked = true
        } else{
            likeButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            clicked = false
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ingredientView{
            return ingredients.count
        } else {
            return stepTitle.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == ingredientView{
            let cell = self.ingredientView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! IngredientCell
            cell.ingredientName.text = ingredients[indexPath.row]
            cell.ingredientDosage.text = dosages[indexPath.row]
            return cell
        } else {
            let cell = self.stepView.dequeueReusableCellWithIdentifier("stepcell", forIndexPath: indexPath) as! StepTableViewCell
            cell.stepPic.image = stepPhoto[indexPath.row]
            cell.stepTitle.text = stepTitle[indexPath.row]
            cell.stepDescription.numberOfLines = 0
            cell.stepDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
            cell.stepDescription.text = stepDescription[indexPath.row]
            cell.tipButton.hidden = tipHidden[indexPath.row]
            cell.tipText.text = stepTip[indexPath.row]
            cell.reminderView.hidden = reminderHidden[indexPath.row]
            cell.stepReminder.text = stepReminder[indexPath.row]
            cell.stepReminder.numberOfLines = 0
            cell.timerView.hidden = timerHidden[indexPath.row]
            cell.timerLabel.text = String(format: "%02d:%02d",stepTimer[indexPath.row],0)
            cell.startButton.tag = indexPath.row
            cell.startButton.addTarget(self, action: "starttimer:", forControlEvents: .TouchUpInside)
            cell.tipButton.tag = indexPath.row
            cell.tipButton.addTarget(self, action: "showtip:", forControlEvents: .TouchUpInside)
            return cell
        }
        
    }
    @IBAction func starttimer(sender: UIButton){
         performSegueWithIdentifier("timer", sender: sender)
    }

    var selectedIndexPath : NSIndexPath?

    @IBAction func showtip(sender: UIButton){
        let thisIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        
        let previousIndexPath = selectedIndexPath
        if thisIndexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = thisIndexPath
        }
        
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            self.stepView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }

    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == stepView{
            (cell as! StepTableViewCell).watchFrameChanges()

        }
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == stepView{
            (cell as! StepTableViewCell).ignoreFrameChanges()
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in stepView.visibleCells as! [StepTableViewCell] {
            cell.ignoreFrameChanges()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == stepView{
            if indexPath == selectedIndexPath {
                return StepTableViewCell.expandedHeight
            } else {
                return StepTableViewCell.defaultHeight
            }
        } else{
            return 24
        }
        
    }


    @IBAction func gotoOverview(sender: UIButton) {
        ScrollView.contentOffset = CGPointMake(0,0)
    }
    
    @IBAction func gotoIngredient(sender: UIButton) {
        
        ScrollView.contentOffset = CGPointMake(0,ingredientLabel.frame.minY)
    }
    @IBAction func gotoStep(sender: UIButton) {
        ScrollView.contentOffset = CGPointMake(0,stepLabel.frame.minY)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "timer"){
            let totalTime = stepTimer[sender!.tag]
            let DestViewController = segue.destinationViewController as! timerViewController
            DestViewController.totalTime = totalTime
        }
        
    }

}

