//
//  FavoriteViewController.swift
//  MusicListApp
//
//  Created by Yusuke Mitsugi on 2020/06/02.
//  Copyright © 2020 Yusuke Mitsugi. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import PKHUD
import AVFoundation



class PlayMusicButton:UIButton {
    
    var params: Dictionary<String, Any>
    
    override init(frame: CGRect) {
        self.params = [:]
        //親クラスのinitを使う
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.params = [:]
        super.init(coder: aDecoder)
    }
}



class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, URLSessionDownloadDelegate {
    
    @IBOutlet weak var favTableView: UITableView!
    
    var musicDataModelArray = [MusicDataModel]()
    var artworkUrl = ""
    var previewUrl = ""
    var artistName = ""
    var trackCensoredName = ""
    var imageString = ""
    var userID = ""
    var favRef = Database.database().reference()
    var userName = ""
    
    var player: AVAudioPlayer?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //セルを選択不可にする
        favTableView.allowsSelection = true
        if UserDefaults.standard.object(forKey: "userID") != nil {
            userID = UserDefaults.standard.object(forKey: "userID") as! String
        }
        if UserDefaults.standard.object(forKey: "userName") != nil {
            userName = UserDefaults.standard.object(forKey: "userName") as! String
            //バーに名前を出す
            self.title = "\(userName)'s MusicList"
        }
        favTableView.delegate = self
        favTableView.dataSource = self
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "\(userName)'s MusicList"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //インディケーターを回す
        HUD.show(.progress)
        //値を取得する（usersのIDの下にある自分のコンテンツの全て）
        favRef.child("users").child(userID).observe(.value) {
            (snapshot) in
            //何回も検索すると値が残ってるので、毎回空にしてから検索する
            self.musicDataModelArray.removeAll()
            //snapshotに値が入ったら、DBのIDの下を取得する
            for child in snapshot.children {
                //型を決めて、初期化
                let childSnapshot = child as! DataSnapshot
                //モデルを初期化
                let musicData = MusicDataModel(snapshot: childSnapshot)
                self.musicDataModelArray.insert(musicData, at: 0)
                self.favTableView.reloadData()
            }
            HUD.hide()
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicDataModelArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let musicDataModel = musicDataModelArray[indexPath.row]
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let label1 = cell.contentView.viewWithTag(2) as! UILabel
        let label2 = cell.contentView.viewWithTag(3) as! UILabel
        label1.text = musicDataModel.artistName
        label2.text = musicDataModel.musicName
        imageView.sd_setImage(with: URL(string: musicDataModel.imageString),
                              placeholderImage: UIImage(named: "noImage"),
                              options: .continueInBackground,
                              context: nil,
                              progress: nil,
                              completed: nil)
        //再生ボタン
        let playButton = PlayMusicButton(frame: CGRect(x: view.frame.size.width-60,
                                                       y: 50,
                                                       width: 60,
                                                       height: 60))
//        playButton.setImage(UIImage(named: "play"), for: .normal)
        playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        //playButtonが押された時のメソッド
        playButton.addTarget(self, action: #selector(playButtonTap(_ :)), for: .touchUpInside)
        playButton.params["value"] = indexPath.row
        cell.accessoryView = playButton
        return cell
    }
    
    
    
    
    @objc func playButtonTap(_ sender: PlayMusicButton) {
        //音楽を止める
        if player?.isPlaying == true {
            player?.stop()
        }
        else {
            player?.play()
        }
        //sender = playButton  paramsはモデルにある。　セルが押された配列の番号はどこですか。
        let indexNumber:Int = sender.params["value"] as! Int
        //再生するURLを取得する
        let urlString = musicDataModelArray[indexNumber].previewURL
        let url = URL(string: urlString!)
        print(url!)
        //ダウンロード
        downloadMusicURL(url: url!)
    }

    
    
    @IBAction func back(_ sender: Any) {
        //音楽を止める
        if player?.isPlaying == true {
            player?.stop()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
     //ダウンロードメソッド  左の引数url = previewURL
    func downloadMusicURL(url:URL) {
        var downloadTask: URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (url, response, error) in
            //再生
            self.play(url: url!)
        })
        downloadTask.resume()
    }
    
    
    
    func play(url: URL) {
        //実行文
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.volume = 1.0
            player?.play()
            //エラーが発生したら呼ばれる
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    //ダウンロードが終わった時に呼ばれる
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Done")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
