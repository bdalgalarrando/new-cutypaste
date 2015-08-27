//
//  PostInfo.swift
//  CutyPaste
//
//  Created by Catalina Balmaceda on 21-08-15.
//  Copyright (c) 2015 Catalina Balmaceda. All rights reserved.
//

import Foundation
import SwiftyJSON

class PostInfo {
    let url: String
    let title:String
    let date: String
    let content: String
    let slug: String
    let author: Author
    let categories: Categories
    
    init(data: JSON) {
        
        self.url = data["url"].stringValue
        self.title = data["title"].stringValue
        self.slug = data["slug"].stringValue
        self.date = data["date"].stringValue
        self.content = data["content"].stringValue
        self.author = Author(infoauthor:data["author"] as JSON)
        self.categories = Categories(info:data["categories"] as JSON) // enviar data de un arreglo en vez de un diccionario
    }
}