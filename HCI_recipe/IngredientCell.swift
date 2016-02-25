//
//  IngredientCell.swift
//  HCI_recipe
//
//  Created by Jie Tan on 2/16/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {

    @IBOutlet var ingredientName: UILabel!
    @IBOutlet var ingredientDosage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
