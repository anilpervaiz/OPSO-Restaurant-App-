//
//  LoginModel.swift
//  OPSO
//
//  Created by Anil Pervaiz on 7/18/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import UIKit
class logins: Codable {
    let login: login
    let success: String
    

    init(login: login, success: String) {
        
        self.login = login
        self.success = success

    }
}

class login: Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let photo: String
     let phone: String
     let location: String
    init(id: String , name: String , email: String , password: String , photo: String,  phone: String, location: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.photo = photo
        self.phone = photo
        self.location = photo
    }
}
