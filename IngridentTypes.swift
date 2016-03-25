//
//  IngridentTypes.swift
//  HCI_recipe
//
//  Created by allen woo on 2/22/16.
//  Copyright © 2016 Chimian Wu. All rights reserved.
//

import UIKit

class IngridentTypes: NSObject {
    var Ingtype: String
    var photo: UIImage?
    var sub_imgs :[UIImage] = []
    var sub_names: [String] = []
    
    
// Mark: Initialization;   Append image using name array
    init?(type: String, photo: UIImage?, sub_names: [String]) {
        self.Ingtype = type
        self.sub_names = [type] +  sub_names
        self.photo = photo
        sub_imgs.append(photo!)
        for img_name in sub_names {
            sub_imgs.append(UIImage(named:img_name)!)
        }
    }
}