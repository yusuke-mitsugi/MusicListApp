//
//  SearchViewController.swift
//  MusicListApp
//
//  Created by Yusuke Mitsugi on 2020/06/01.
//  Copyright © 2020 Yusuke Mitsugi. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire
import SwiftyJSON
import DTGradientButton
import Firebase
import FirebaseAuth
import ChameleonFramework



class SearchViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
    var artistNameArray = [String]()
    var musicNameArray = [String]()
    var previewURLArray = [String]()
    var imageStringArray = [String]()
    var userID = String()
    var userName = String()
    var autoID = String()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "autoID") != nil {
            autoID = UserDefaults.standard.object(forKey: "autoID") as! String
            print(autoID)
        } else {
            //新規登録してなかったら、ログイン画面に飛ばす
            let storyBoad = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyBoad.instantiateViewController(identifier: "LoginViewController")
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
        if UserDefaults.standard.object(forKey: "userID") != nil && UserDefaults.standard.object(forKey: "userName") != nil {
            userID = UserDefaults.standard.object(forKey: "userID") as! String
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        }
        searchTextField.delegate = self
        //キーボードを出す
        searchTextField.becomeFirstResponder()
        //グラデーション
        favButton.setGradientBackgroundColors([UIColor(hex:"E21F70"),
                                               UIColor(hex:"FF4D2C")],
                                              direction: .toBottom, for: .normal)
        listButton.setGradientBackgroundColors([UIColor(hex:"FF8960"),
                                                UIColor(hex:"FF62A5")],
                                               direction: .toBottom,
                                               for: .normal)
        favButton.layer.cornerRadius = 10
        listButton.layer.cornerRadius = 10
    }
    
  
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //バーの色を変更
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.flatRed()
        //バーのbackボタンを消す
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //サーチ検索する
        textField.resignFirstResponder()
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }
    
    
    @IBAction func moveToSelectCardView(_ sender: Any) {
        //JSON解析を行う
        startParse(keyword: searchTextField.text!)
    }
    
    
     func moveToCard() {
        performSegue(withIdentifier: "selectVC", sender: nil)
    }
    
    
    //画面遷移と同時に値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if searchTextField.text != nil && segue.identifier == "selectVC" {
            let selectVC = segue.destination as! SelectViewController
            selectVC.artistNameArray = self.artistNameArray
            selectVC.imageStringArray = self.imageStringArray
            selectVC.musicNameArray = self.musicNameArray
            selectVC.previewURLArray = self.previewURLArray
            selectVC.userID = self.userID
            selectVC.userName = self.userName
        }
    }
    
    
    
    
    //JSON解析。searchTextField.textがkeywordに入ってくる
    func startParse(keyword: String) {
        //インディケーターを回す
        HUD.show(.progress)
        //検索すると毎回配列の中に値が残ってしまうので、毎回初期化するようにする
        imageStringArray = [String]()
        artistNameArray = [String]()
        musicNameArray = [String]()
        previewURLArray = [String]()
        //どのURLで表示されているJSONを解析するのか
        let urlString = "https://itunes.apple.com/search?term=\(keyword)&country=jp"
        //コンピューターが読めるようにする=エンコード
        let encodeUrlString:String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        //AFでリクエストを投げる
        AF.request(encodeUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {
            (response) in
//            print(response)
            //JSONで表示されているのを取得する
            switch response.result {
            case .success:
                let json:JSON = JSON(response.data as Any)
                //resultCountの数だけ、for文で曲を取得する
                var resultCount:Int = json["resultCount"].int!
                for i in 0 ..< resultCount {
                    var artWorkUrl = json["results"][i]["artworkUrl60"].string
                    //再生するURLの音源の場所
                    let previewUrl = json["results"][i]["previewUrl"].string
                    let artistName = json["results"][i]["artistName"].string
                    let trackCensoredName = json["results"][i]["trackCensoredName"].string
                    //artWorkUrlの画像を大きくする処理
                    if let range = artWorkUrl!.range(of:"60x60bb") {
                        artWorkUrl?.replaceSubrange(range, with:"320x320bb")
                    }
                    //取得した値を配列に入れる
                    self.imageStringArray.append(artWorkUrl!)
                    self.previewURLArray.append(previewUrl!)
                    self.artistNameArray.append(artistName!)
                    self.musicNameArray.append(trackCensoredName!)
                    //曲をいっぱい取得したので、カード画面へ遷移
                    if self.musicNameArray.count == resultCount {
                        self.moveToCard()
                    }
                }
                //ぐるぐるを閉じる
                HUD.hide()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func moveToFav(_ sender: Any) {
        let favVC = self.storyboard?.instantiateViewController(identifier: "fav") as! FavoriteViewController
        self.navigationController?.pushViewController(favVC, animated: true)
    }
    
    
    @IBAction func moveToList(_ sender: Any) {
        let listVC = self.storyboard?.instantiateViewController(identifier: "list") as! ListTableViewController
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
