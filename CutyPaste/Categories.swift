//
//  Categories.swift
//  CutyPaste
//
//  Copyright (c) 2015 Catalina Balmaceda. All rights reserved.
//

import Foundation
import SwiftyJSON

class Categories {
    
    
    var listaCategories: [Category] = []
    
    
    
    
    //    init() {
    //
    //    }
    //    init(info: JSON) {
    //
    //
    //        for (index: String, subJson: JSON) in info {
    //            let categorypost = Category(categorydata:subJson as JSON)
    //            listaCategories.append(categorypost)
    //
    //
    //
    //        }
    
    
    init(info: JSON) {
        
        for (index: String, subJson: JSON) in info {
            let categorypost = Category(categorydata:subJson as JSON)
            listaCategories.append(categorypost)
            println(categorypost.title)
        }
        println("\n")
        
    }
    
    
    
    
    
}