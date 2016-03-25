//
//  Meat_Singleton.swift
//  HCI_recipe
//
//  Created by allen woo on 2/24/16.
//  Copyright © 2016 Chimian Wu. All rights reserved.
//

import Foundation
// MARK: Singleton class for storing selected Meat and Segue for passing keys in the singleton instance.

class Meat_Singleton {
    // Mark: Maintain a dictionary, key: meat types, value: cutting parts.
    var selected_meat = [String:[String]]()
    
    // Mark: Ensure only one instance exits.
    static let shared_instance = Meat_Singleton()
    private init() {}
}