//
//  RealmUserDetailsModel.swift
//  OPSO
//
//  Created by user on 10/7/19.
//  Copyright © 2019 OPSO. All rights reserved.
//

import Foundation
import RealmSwift



class RealmUserDetails: Object {
    
    @objc dynamic var id: String = ""
      @objc dynamic var name: String = ""
      @objc dynamic var email: String = ""
      @objc dynamic var password: String = ""
      @objc dynamic var photo: String = ""
    @objc dynamic var location: String = ""
      @objc dynamic var phone: String = ""
    
    
    convenience init(id: String,name: String,email: String,password: String,photo: String,location: String,phone: String) {
        self.init()
        self.id = id
         self.name = name
         self.email = email
         self.password = password
         self.photo = photo
         self.location = location
         self.phone = phone
        
    }
    
    convenience init(photo: String) {
        self.init()
        
        self.photo = photo
       
        
    }
    
    
    
}
