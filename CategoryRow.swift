//
//  CategoryRow.swift
//  HCI_recipe
//
//  Created by allen woo on 2/22/16.
//  Copyright © 2016 Chimian Wu. All rights reserved.
//

import Foundation
import UIKit

class CategoryRow : UITableViewCell,UICollectionViewDelegate {
    var num_sec:Int?
    // Mark: Moniter data for Collection View and reload Data after each changes.
    var dic : [UIImage]?{
        didSet {
            collectionView.reloadData()
        }
    }
    var nm : [String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var section_name :String = ""
    @IBOutlet weak var collectionView: UICollectionView!
}

extension CategoryRow : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return num_sec!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("IngCell", forIndexPath: indexPath) as! IngPhotoCell
        
        // MARK: Assign Images to Collection Cell
        cell.Img_View.image = dic![indexPath.row]
        
        // Trim string by searching  "_" for display
        var temp = nm![indexPath.row]
        if (temp.rangeOfString("_") != nil) {
            let rg = temp.rangeOfString("_")
            let dis:Int = temp.startIndex.distanceTo(rg!.startIndex)
            let id = temp.startIndex.advancedBy(dis+1)
            let rg2 = id..<temp.endIndex
             temp = temp[rg2]
        }

        cell.nameSub.text = temp                    // Assign Label values of Cell
        cell.img_name = nm![indexPath.row]    // Store key attribute of the cell
        cell.section_name = section_name        // Assign section name property to collection View cell
        
        // Choose Background colors based on a global dictionary
        let shared_instance = Meat_Singleton.shared_instance
        if shared_instance.selected_meat[section_name]?.contains(cell.img_name) == true{

            cell.backgroundView = UIImageView(image: UIImage(named:"check_img_3"))
        }
        else {
        // MARK: Very Very Important!!! Must Initialize Dictionary with empty values;
            if shared_instance.selected_meat[section_name] == nil {
                shared_instance.selected_meat[section_name] = []
            }
            cell.backgroundView = nil

        }
        return cell
    }
    
    // MARK: Events when item cell is selected
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! IngPhotoCell
        let shared_instance = Meat_Singleton.shared_instance
        if shared_instance.selected_meat[section_name]?.contains(cell.img_name) == true{
            cell.backgroundView = nil
            shared_instance.selected_meat[section_name]?.removeAtIndex((shared_instance.selected_meat[section_name]?.indexOf(cell.img_name))!)
        }
        else {
            shared_instance.selected_meat[section_name]?.append(cell.img_name)
            cell.backgroundView = UIImageView(image: UIImage(named:"check_img_3"))
        }
//        print("Current_Singleton")
//        print(shared_instance.selected_meat)
}
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    }
}

// UICollection delegate protocol for behaviour of layout
extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}