//
//  BannersModel.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/13/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit

class Banners: Codable {
    let banners: [banner]
    init(banners: [banner]) {
        self.banners = banners
    }
}

class banner: Codable {

    let id: String
    let image: String
    
    init(id: String, image: String) {
        self.id = id
        self.image = image
    }
}
