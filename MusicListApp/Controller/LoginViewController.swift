//
//  LoginViewController.swift
//  MusicListApp
//
//  Created by Yusuke Mitsugi on 2020/06/01.
//  Copyright © 2020 Yusuke Mitsugi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import DTGradientButton


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        //新規登録ボタンのグラデーション
        loginButton.setGradientBackgroundColors([UIColor(hex:"E21F70"), UIColor(hex:"FF4D2C")], direction: .toBottom, for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    @IBAction func login(_ sender: Any) {
        if textField.text?.isEmpty != true {
            UserDefaults.standard.set(textField.text, forKey: "userName")
        } else {
            //空なら、振動させる
            let generator = UINotificationFeedbackGenerator()
            //振動のタイプを決める
            generator.notificationOccurred(.error)
            print("振動")
        }
        //Firebaseに、IDと名前（textField.text）を入れる
        Auth.auth().signInAnonymously { (result, error) in
            if error == nil {
                //userIDを取得する。result?.userがあれば入り、そうでない場合return
                guard let user = result?.user else {return}
                let userID = user.uid
                UserDefaults.standard.set(userID, forKey: "userID")
                //外部からここに引っ張ってきたら、次はModelのSaveProfileに飛ぶ
                let saveProfile = SaveProfile(userID: userID, userName: self.textField.text!)
                saveProfile.saveProfile()
                //databaseに値が入ったら閉じる
                self.dismiss(animated: true, completion: nil)
            } else {
                //エラーメッセージを出す
                print(error?.localizedDescription as Any)
            }
        }
    }
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
