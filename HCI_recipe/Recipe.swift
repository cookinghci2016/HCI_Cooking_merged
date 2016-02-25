//
//  Recipe.swift
//  HCI_recipe
//
//  Created by Jie Tan on 2/16/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit

class Recipe {
    
    var name: String
    var photo: UIImage?
    var description: String
    
    init?(name: String, photo: UIImage?, description: String) {
        self.name = name
        self.photo = photo
        self.description = description
        
        if name.isEmpty {
            return nil
        }
    }
    
    
}
