//
//  User.swift
//  iossqlitestudy
//
//  Created by kenan on 26.08.2024.
//

import Foundation

class User{
    var user_id:Int?
    var user_name:String?
    var user_age:Int?
    
    init(user_id:Int,user_name:String,user_age:Int){
        self.user_id = user_id
        self.user_name = user_name
        self.user_age = user_age
    }
    
    init() {
        
    }
    

    
}
