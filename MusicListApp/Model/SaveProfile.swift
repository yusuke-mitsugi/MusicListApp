//
//  SaveProfile.swift
//  MusicListApp
//
//  Created by Yusuke Mitsugi on 2020/06/01.
//  Copyright © 2020 Yusuke Mitsugi. All rights reserved.
//

import Foundation
import Firebase
import PKHUD


//サーバーに値を飛ばす
class SaveProfile {
    
    var userID:String! = ""
    var userName:String! = ""
    var ref:DatabaseReference!
    
    //外部からStringに入ってきて、その後左側に入る
    init(userID:String, userName:String) {
        //その後自身（self）に入る
        self.userID = userID
        self.userName = userName
        //ログインの時に拾えるuidを先頭に付けて送信する。
        //受信する時もuidから引っ張る
        //初期化すると同時にrefarenceが生成される
        ref = Database.database().reference().child("profile").childByAutoId()
    }
    
    
    init(snapShot: DataSnapshot) {
        ref = snapShot.ref
        if let value = snapShot.value as? [String:Any] {
            userID = value["userID"] as? String
            userName = value["userName"] as? String
        }
    }
    
    
    func toContents()->[String:Any] {
        //キー値
        return["userID": userID, "userName": userName as Any]
    }
    
    
    
    func saveProfile() {
        //refに値として保存する
        ref.setValue(toContents())
        UserDefaults.standard.set(ref.key, forKey: "autoID")
    }
    
    
    
    
    
    
    
    
}


























