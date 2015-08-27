//
//  Category.swift
//  CutyPaste
//
//  Created by Catalina Balmaceda on 21-08-15.
//  Copyright (c) 2015 Catalina Balmaceda. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category {
    
    let id: String
    let slug:String
    let title: String
    //    let description: String
    //    let parent: String
    //    let post_count: String
    
    
    init(categorydata: JSON) {
        self.id = categorydata["id"].stringValue
        self.slug = categorydata["slug"].stringValue
        self.title = categorydata["title"].stringValue
        //        self.description = categorydata["description"].stringValue
        //        self.parent = categorydata["parent"].stringValue
        //        self.post_count = categorydata["post_count"].stringValue
    }
}