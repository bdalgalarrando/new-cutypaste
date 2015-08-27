//
//  MenuCollectionViewCell.swift
//  CutyPaste
//
//  Created by Catalina Balmaceda on 21-08-15.
//  Copyright (c) 2015 Catalina Balmaceda. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var MenuImage: UIImageView!
    @IBOutlet weak var MenuTitle: UILabel!

    @IBOutlet weak var MenuDate: UILabel!
    @IBOutlet weak var MenuBy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    
    }

}
