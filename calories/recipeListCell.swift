//
//  recipeListCell.swift
//  calories
//
//  Created by Alexey Savchenko on 23.11.16.
//  Copyright © 2016 Alexey Savchenko. All rights reserved.
//

import UIKit

class recipeListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // MARK: PROPERTIES
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    
    
    // MARK: METHODS
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
