//
//  CategoryRow.swift
//  HCI_recipe
//
//  Created by allen woo on 2/22/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//
// TODO:  2  When updating the UIcollection cell, access value of slectedIng   3 In Meatcontroller, once change of slectedIng detected, update the value of slectedItem(Global var for storing selected items)


import UIKit
class CategoryRow : UITableViewCell,UICollectionViewDelegate {
    var num_sec:Int?
    // Moniter data for Collection View and reload Data after each changes.
    var dic : [UIImage]?{
        didSet {
            collectionView.reloadData()  //    TODO: 会把原来的都覆盖掉吗   每次的选择也会吗？  怎么解决
        }
    }
    var nm : [String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var section_name :String = ""
    var temp_dic = [UIImage:Bool]()
    
    // Update the selected to Meat Singleton
    var selectedIng_string = [String](){
        didSet {
        let shared_instance = Meat_Singleton.shared_instance
//        shared_instance.selected_meat[self.section_name] = selectedIng_string
        print(shared_instance.selected_meat)
        }
    }
    
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
//        if indexPath.row == 0 {
//            cell.nameSub.text = "General"
//        }
//        else {
//            cell.nameSub.text = nm![indexPath.row]
//        }
        cell.nameSub.text = nm![indexPath.row]
        cell.section_name = section_name    // Assign section name property to collection View cell
        
        // Decide Background colors based on a global array
//        if selectedIng_string.contains(cell.nameSub.text!) {
        let shared_instance = Meat_Singleton.shared_instance
        if shared_instance.selected_meat[section_name]?.contains(cell.nameSub.text!) == true{
            cell.backgroundColor = UIColor.greenColor()
        }
        else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        return cell
    }
    
    // 某个cell 被选中的事件处理
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! IngPhotoCell
        let shared_instance = Meat_Singleton.shared_instance
        
//        if selectedIng_string.contains(cell.nameSub.text!) {
        
        if shared_instance.selected_meat[section_name]?.contains(cell.nameSub.text!) == true{
            print("变暗位置")
            print(indexPath.section)
            print(indexPath.row)
            cell.backgroundColor = UIColor.whiteColor()
//            selectedIng_string.removeAtIndex(selectedIng_string.indexOf(cell.nameSub.text!)!)
            shared_instance.selected_meat[section_name]?.removeAtIndex((shared_instance.selected_meat[section_name]?.indexOf(cell.nameSub.text!))!)
            print(shared_instance.selected_meat)
        }
        else {
            print("点亮位置")
            print(indexPath.section)
            print(indexPath.row)
//            selectedIng_string.append(cell.nameSub.text!)
            shared_instance.selected_meat[section_name]?.append(cell.nameSub.text!)
            print(shared_instance.selected_meat)
            cell.backgroundColor = UIColor.greenColor()
        }
            
        print(selectedIng_string)
        
        let test: Shared_data = Shared_data.instance
        test.num = test.num + 1
        print("Current test number =", test.num)

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