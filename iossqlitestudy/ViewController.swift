//
//  ViewController.swift
//  iossqlitestudy
//
//  Created by kenan on 26.08.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        copyDB()
        UserDAO().insertData(user_name: "Ahmet", user_age: 24)
        
        var gelenListe = UserDAO().getAllUsers()
        for user in gelenListe{
            if let ad = user.user_name{
                print("Ad \(ad) Yaş \(user.user_age)")
            }
        }
    }
    
    func copyDB(){
        let bundlePath = Bundle.main.path(forResource: "usersdb", ofType: ".sqlite")
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let pathToBeCopied = URL(fileURLWithPath: targetPath).appendingPathComponent("usersdb.sqlite")
        if fileManager.fileExists(atPath: pathToBeCopied.path){
        print("veritabanı zaten mevcut")
        }else{
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath: pathToBeCopied.path)
            }catch{
                print("hata")
            }
        }
    }


}

