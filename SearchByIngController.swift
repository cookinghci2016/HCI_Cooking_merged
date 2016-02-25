//
//  SearchByIngController.swift
//  HCI_recipe
//
//  Created by allen woo on 2/20/16.
//  Copyright © 2016 Je Tan. All rights reserved.
//

import UIKit

class SearchByIngController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var Meat: UIButton!
    @IBOutlet weak var Veg: UIButton!
    @IBOutlet weak var Fruit: UIButton!
    
    @IBOutlet weak var Sea: UIButton!
    @IBOutlet weak var Yummy: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!

    var all_selected_items : [String] = [] {
//    var all_selected_items : Set<String> = [] {
        didSet {
            print("ValueGet")
//            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToViewController(sender: UIStoryboardSegue) {
        if sender.identifier != nil {
            if sender.identifier == "dataBack" {
                var temp : [String] = []
                all_selected_items.removeAll()
                let shared_instance = Meat_Singleton.shared_instance
                for (mykey,_) in shared_instance.selected_meat {
                    temp += shared_instance.selected_meat[mykey]!
                }
                all_selected_items += temp
                collectionView.reloadData()
            }
        }
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return all_selected_items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("boardcell", forIndexPath: indexPath) as! CuttingBoardCell
//         let  item = all_selected_items[all_selected_items.startIndex.advancedBy(indexPath.row)]
        let item = all_selected_items[indexPath.row]
        
        cell.DisplayButton.setImage(UIImage(named: item), forState:.Normal)
        cell.DisplayButton.addTarget(self, action: "btnAction:", forControlEvents: .TouchUpInside)
        return cell
    }
    
}



     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


