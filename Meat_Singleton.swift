//
//  Meat_Singleton.swift
//  HCI_recipe
//
//  Created by allen woo on 2/24/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import Foundation

class Meat_Singleton {
    var selected_meat = [String:[String]]()
    static let shared_instance = Meat_Singleton()
    private init() {}
}