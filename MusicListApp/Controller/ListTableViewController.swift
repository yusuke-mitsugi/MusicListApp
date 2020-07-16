//
//  ListTableViewController.swift
//  MusicListApp
//
//  Created by Yusuke Mitsugi on 2020/06/03.
//  Copyright © 2020 Yusuke Mitsugi. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseAuth
import PKHUD



class ListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var listRef = Database.database().reference()
    var indexNumber = Int()
    
    var getUserIDModelArray = [GetUserIDModel]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    //画面が表示されるごとに呼ばれる
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        HUD.show(.success)
        //コンテンツを、DBのプロフィールから下を取得する
        listRef.child("profile").observe(.value) { (snapshot) in
            HUD.hide()
            self.getUserIDModelArray.removeAll()
            for child in snapshot.children {
                //　childの型を決める。型はモデルに作ってある。
                let childSnapshot = child as! DataSnapshot
                let listData = GetUserIDModel(snapshot: childSnapshot)
                self.getUserIDModelArray.insert(listData, at: 0)
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getUserIDModelArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        let listDataModel = getUserIDModelArray[indexPath.row]
        let userNameLabel = cell.contentView.viewWithTag(1) as! UILabel
        userNameLabel.text = "\(listDataModel.userName!)'s List"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let otherVC = self.storyboard?.instantiateViewController(identifier: "otherList") as! OtherPersonListViewController
        let listDataModel = getUserIDModelArray[indexPath.row]
        otherVC.userName = listDataModel.userName
        otherVC.userID = listDataModel.userID
        self.navigationController?.pushViewController(otherVC, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
