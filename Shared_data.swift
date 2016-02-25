//
//  Shared_data.swift
//  HCI_recipe
//
//  Created by allen woo on 2/24/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

// Singleton Instance test
import Foundation

class Shared_data {
    var num:Int = 1
    var selectedIng = [String:[String]]()

    static let instance = Shared_data()
    private init() {}
}
