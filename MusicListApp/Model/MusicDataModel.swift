//
//  MusicDataModel.swift
//  MusicListApp
//
//  Created by Yusuke Mitsugi on 2020/06/02.
//  Copyright © 2020 Yusuke Mitsugi. All rights reserved.
//

import Foundation
import Firebase
import PKHUD



class MusicDataModel {
    
    
    var artistName:String! = ""
    var musicName:String! = ""
    var previewURL:String! = ""
    var imageString:String! = ""
    var userID:String! = ""
    var userName:String! = ""
    
    var artistViewUrl:String! = ""
    let ref:DatabaseReference!
    
    var key:String = ""
    
    
    //indexNumber番目が右の外部引数に入る
    init(artistName:String, musicName:String, previewURL:String, imageString:String, userID:String, userName:String) {
        self.artistName = artistName
        self.musicName = musicName
        self.previewURL = previewURL
        self.imageString = imageString
        self.userID = userID
        self.userName = userName
        //ログインする時に取得するuidを先頭に付けて送信。
        //受信する時もuidから取得
        ref = Database.database().reference().child("users").child(userID).childByAutoId()
    }
    
    
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as? [String:Any] {
            //右の外部引数が、左側のこのモデルのプロバティに入る
            artistName = value["artistName"] as? String
            musicName = value["musicName"] as? String
            previewURL = value["previewURL"] as? String
            imageString = value["imageString"] as? String
            userID = value["userID"] as? String
            userName = value["userName"] as? String
        }
    }
    
    
    
    func toContents()->[String:Any] {
        //キー値を付けて、dictionary型にする
        return [
            "artistName":artistName!,
            "musicName":musicName!,
            "previewURL":previewURL!,
            "imageString":imageString!,
            "userID":userID!,
            "userName":userName!
        ]
    }
    
    
    
    func save() {
        ref.setValue(toContents())
    }
    
    
    
    
    
    
    
    
    
    
    
    
}



























