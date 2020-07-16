    //
    //  GetUserIDModel.swift
    //  MusicListApp
    //
    //  Created by Yusuke Mitsugi on 2020/06/03.
    //  Copyright © 2020 Yusuke Mitsugi. All rights reserved.
    //
    
    import Foundation
    import Firebase
    import PKHUD
    
    
    
    class GetUserIDModel {
        
        var userID:String! = ""
        var userName:String! = ""
        
        var ref:DatabaseReference! = Database.database().reference().child("profile")
        
        
        init(snapshot:DataSnapshot) {
            ref = snapshot.ref
            if let value = snapshot.value as? [String: Any] {
                userID = value["userID"] as? String
                userName = value["userName"] as? String
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
