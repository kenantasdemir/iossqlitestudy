//
//  UserDAO.swift
//  iossqlitestudy
//
//  Created by kenan on 26.08.2024.
//

import Foundation


class UserDAO{
    let db:FMDatabase?
    
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbPath = URL(fileURLWithPath: targetPath).appendingPathComponent("usersdb.sqlite")
        db = FMDatabase(path: dbPath.path)
    }
    
    func insertData(user_name:String,user_age:Int){
        db?.open()
        
        do{
            try db?.executeUpdate("INSERT INTO users (user_name,user_age) VALUES (?,?)",values: [user_name,user_age])
        }catch{
            print(error.localizedDescription)
        }
        
        
        db?.close()
    }
    
    func getAllUsers()->[User]{
        var liste = [User]()
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM users", values: nil)
            while rs.next(){
                let user = User(user_id: Int(rs.string(forColumn: "user_id"))!,
                                user_name: rs.string(forColumn: "user_name"),
                                user_age: Int(rs.string(forColumn: "user_age"))!)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        return liste
    }
    
    
    func deleteUser(user_id:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM users WHERE user_id = ?",values: [user_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func updateUser(user_id:Int,user_name:String,user_age:Int){
        db?.open()
        
        do{
            try db?.executeUpdate("UPDATE users SET user_name = ?, user_age = ? WHERE user_id = ?", values: [user_name,user_age,user_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    func checkRecord(user_name:String)->Int{
        var sonuc = 0
        db?.open()
        
        do{
            let rs = try db!.executeQuery("SELECT count(*) as sonuc FROM users WHERE user_name = ?", values: [user_name])
            while rs.next(){
                sonuc = Int(rs.string(forColumn: "sonuc"))!
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.open()
        return sonuc
    }
    
    
    func searchUser(user_name:String)->[User]{
        var liste = [User]()
        db?.open()
        
        do{
            
            let rs = try db!.executeQuery("SELECT * FROM users WHERE user_name like '%\(user_name)%'", values: nil)
            
            while rs.next() {
                let user = User(user_id: Int(rs.string(forColumn: "user_id"))!
                    , user_name: rs.string(forColumn: "user_name")!
                    , user_age: Int(rs.string(forColumn: "user_age"))!)
                
                liste.append(user)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        
        db?.close()
        return liste
    }
    
    func getUser(user_id:Int) -> User {
        var user = User()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM users WHERE user_id = ?", values: [user_id])
            
            while rs.next() {
                user = User(user_id: Int(rs.string(forColumn: "user_id"))!
                    , user_name: rs.string(forColumn: "user_name")!
                    , user_age: Int(rs.string(forColumn: "user_age"))!)
                
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return user
        
        
    }
    
    func getAllUserAsLimited() -> [User] {
        var liste = [User]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM users LIMIT 2", values: nil)
            
            while rs.next() {
                let user = User(user_id: Int(rs.string(forColumn: "user_id"))!
                    , user_name: rs.string(forColumn: "user_name")!
                    , user_age: Int(rs.string(forColumn: "user_age"))!)
                
                liste.append(user)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
    
    func getRandom2Users() -> [User] {
        var liste = [User]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM ORDER BY RANDOM() users LIMIT 2", values: nil)
            
            while rs.next() {
                let user = User(user_id: Int(rs.string(forColumn: "user_id"))!
                    , user_name: rs.string(forColumn: "user_name")!
                    , user_age: Int(rs.string(forColumn: "user_age"))!)
                
                liste.append(user)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
    
}
