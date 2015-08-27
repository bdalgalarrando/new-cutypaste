//
//  Author.swift
//  CutyPaste
//
//  Created by Catalina Balmaceda on 21-08-15.
//  Copyright (c) 2015 Catalina Balmaceda. All rights reserved.
//


import Foundation
import SwiftyJSON

class Author {
    //   let id: String
    //    let slug:String
    //    let name: String
    let firstName: String
    let lastName: String
    //    let nickname: String
    //    let url: String
    //    let description: String
    
    init(infoauthor: JSON) {
        //println("\n\n\(data)")
        //        self.id = infoauthor["id"].stringValue
        //        self.slug = infoauthor["slug"].stringValue
        //        self.name = infoauthor["name"].stringValue
        self.firstName = infoauthor["first_name"].stringValue
        self.lastName = infoauthor["last_name"].stringValue
        //        self.nickname = infoauthor["nickname"].stringValue
        //        self.url = infoauthor["url"].stringValue
        //        self.description = infoauthor["description"].stringValue
        
    }
    
}