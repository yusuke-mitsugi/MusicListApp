//
//  SelectViewController.swift
//  MusicListApp
//
//  Created by Yusuke Mitsugi on 2020/06/02.
//  Copyright © 2020 Yusuke Mitsugi. All rights reserved.
//

import UIKit
//↓ティンダーみたいなライブラリ
import VerticalCardSwiper
import SDWebImage
import Firebase
import PKHUD
import ChameleonFramework



class SelectViewController: UIViewController, VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
    
    //受け取り用
    var artistNameArray = [String]()
    var musicNameArray = [String]()
    var previewURLArray = [String]()
    var imageStringArray = [String]()
    
    var indexNumber = Int()
    var userID = String()
    var userName = String()
    
    //右にスワイプしてお気に入りに入れる配列
    var likeArtistNameArray = [String]()
    var likeMusicNameArray = [String]()
    var likePreviewURLArray = [String]()
    var likeImageStringArray = [String]()
    var likeArtistURLArray = [String]()
    
    @IBOutlet weak var cardSwiper: VerticalCardSwiper!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardSwiper.delegate = self
        cardSwiper.datasource = self
        cardSwiper.reloadData()
        //xibファイルを呼び出す
        cardSwiper.register(nib:UINib(nibName: "CardViewCell", bundle: nil), forCellWithReuseIdentifier: "CardViewCell")
    }
    
    
    
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return artistNameArray.count
    }
    
    
    //カードの数だけ下が呼ばれる
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: index) as? CardViewCell {
            verticalCardSwiperView.backgroundColor = UIColor.randomFlat()
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            //カードに配列を表示する
            let artistName = artistNameArray[index]
            let musicName = musicNameArray[index]
            cardCell.setRandomBackgroundColor()
            cardCell.artistNameLabel.text = artistName
            cardCell.artistNameLabel.textColor = UIColor.white
            cardCell.musicNameLabel.text = musicName
            cardCell.musicNameLabel.textColor = UIColor.white
            //imageViewを表示させる
            cardCell.artWorkImageView.sd_setImage(with: URL(string: imageStringArray[index]), completed: nil)
            return cardCell
        }
        //cardCellがない場合は、空のCardCellを返す
        return CardViewCell()
    }
    
    
    
    //スワイプをした時に、配列から消すメソッド
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        indexNumber = index
        if swipeDirection == .Right {
            likeArtistNameArray.append(artistNameArray[indexNumber])
            likeMusicNameArray.append(musicNameArray[indexNumber])
            likePreviewURLArray.append(previewURLArray[indexNumber])
            likeImageStringArray.append(imageStringArray[indexNumber])
            if likeArtistNameArray.count != 0 && likeMusicNameArray.count != 0 && likePreviewURLArray.count != 0 && likeImageStringArray.count != 0 {
                let musicDataModel = MusicDataModel(artistName: artistNameArray[indexNumber],
                                                    musicName: musicNameArray[indexNumber], previewURL: previewURLArray[indexNumber],
                                                    imageString: imageStringArray[indexNumber],
                                                    userID: userID, userName: userName)
                musicDataModel.save()
            }
        }
        artistNameArray.remove(at: index)
        musicNameArray.remove(at: index)
        previewURLArray.remove(at: index)
        imageStringArray.remove(at: index)
    }
    
    
    
    
    
    
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        //何番目が検知されたか
        indexNumber = index
        //右にスワイプした時に呼ばれる
        if swipeDirection == .Right {
            //右にスワイプした時に、お気に入り配列に入れる
            likeArtistNameArray.append(artistNameArray[indexNumber])
            likeMusicNameArray.append(musicNameArray[indexNumber])
            likeArtistURLArray.append(previewURLArray[indexNumber])
            likeImageStringArray.append(imageStringArray[indexNumber])
            if likeArtistNameArray.count != 0 && likeMusicNameArray.count != 0 && likeArtistURLArray.count != 0 && likeImageStringArray.count != 0 {
                //userIDとuserNameは先に渡ってきてる
                let musicDataModel = MusicDataModel(artistName: artistNameArray[indexNumber],
                                                    musicName: musicNameArray[indexNumber],
                                                    previewURL: previewURLArray[indexNumber],
                                                    imageString: imageStringArray[indexNumber],
                                                    userID: userID, userName: userName)
                //上記がFirebaseに入る
                musicDataModel.save()
            }
        }
    }
    
    
    
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
