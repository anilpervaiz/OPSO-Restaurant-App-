//
//  MenuCategoryModel.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/15/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit

class menucats: Codable {
    let menucat: [menucat]
    init(menucat: [menucat]) {
        
        self.menucat = menucat
    }
}

class menucat: Codable {

    let menusubid: String
    let title: String
    
    init(menusubid: String, title: String) {
        self.menusubid = menusubid
        self.title = title
    }
}

