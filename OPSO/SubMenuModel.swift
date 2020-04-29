//
//  SubMenuModel.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/16/19.
//  Copyright © 2019 OPSO. All rights reserved.
//
import  UIKit
class menuitems: Codable {
    let menuitem: [menuitem]
    init(menuitem: [menuitem]) {
        
        self.menuitem = menuitem
    }
}

class menuitem: Codable {

    let menuitemsid: String
    let title: String
let description: String
let price: String
    let image: String
init(menuitemsid: String, title: String,description: String , price:String, image: String) {
        self.menuitemsid = menuitemsid
        self.title = title
     self.description = description
     self.price = price
     self.image = image
    }
}
