//
//  CategoryRow.swift
//  HCI_recipe
//
//  Created by allen woo on 2/22/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//
// TODO:  2  When updating the UIcollection cell, access value of slectedIng   3 In Meatcontroller, once change of slectedIng detected, update the value of slectedItem(Global var for storing selected items)

import Foundation
import UIKit

class CategoryRow : UITableViewCell,UICollectionViewDelegate {
    var num_sec:Int?
    // Moniter data for Collection View and reload Data after each changes.
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
  
    // Outlet of collectionView  very important!!!
    @IBOutlet weak var collectionView: UICollectionView!
    
}

extension CategoryRow : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return num_sec!
    }
    
    // 用 "IngCell"标记某一个ingredient cell;
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("IngCell", forIndexPath: indexPath) as! IngPhotoCell
        // Assign Images to Collection Cell
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
        
//        if indexPath.row == 0 {
//            cell.nameSub.text = "General"
//        }

        // Choose Background colors based on a global dictionary
        let shared_instance = Meat_Singleton.shared_instance
        if shared_instance.selected_meat[section_name]?.contains(cell.img_name) == true{
//            cell.backgroundColor = UIColor.greenColor()
            cell.backgroundView = UIImageView(image: UIImage(named:"check_img_3"))
        }
        else {
            // Very Very Important!!! Initialize Dictionary with empty values;
            if shared_instance.selected_meat[section_name] == nil {
                shared_instance.selected_meat[section_name] = []
            }
//            cell.backgroundColor = UIColor.whiteColor()
            cell.backgroundView = nil

        }
        return cell
    }
    
    // 某个cell 被选中的事件处理;
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! IngPhotoCell
        let shared_instance = Meat_Singleton.shared_instance
        if shared_instance.selected_meat[section_name]?.contains(cell.img_name) == true{
//            cell.backgroundColor = UIColor.whiteColor()
            cell.backgroundView = nil

            shared_instance.selected_meat[section_name]?.removeAtIndex((shared_instance.selected_meat[section_name]?.indexOf(cell.img_name))!)
//            print("变暗位置")
//            print(indexPath.section)
//            print(indexPath.row)
        }
        else {
            shared_instance.selected_meat[section_name]?.append(cell.img_name)
//          cell.backgroundColor = UIColor.greenColor()
            cell.backgroundView = UIImageView(image: UIImage(named:"check_img_3"))
//            print("点亮位置")
//            print(indexPath.section)
//            print(indexPath.row)
        }
        print("Current_Singleton")
        print(shared_instance.selected_meat)
}
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//        let selectedCell:UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
//        selectedCell.backgroundColor = UIColor.whiteColor()
        
//        let cell:UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
//        if temp_dic[indexPath]  == true
//        cell.backgroundColor = UIColor.whiteColor()
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