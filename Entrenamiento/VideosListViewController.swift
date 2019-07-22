//
//  VideosListViewController.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 21/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation
import UIKit

class VideosListViewController: UIViewController {
    
    @IBOutlet weak var videosListCollectionView: VideosListCollectionView!
    @IBOutlet weak var videosTabBarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videosTabBarItem.title = "Vídeos"
        
        DispatchQueue.global(qos: .background).async(execute: {
            let gamesList = GameData.getAllGames()
            
            DispatchQueue.main.sync {
                self.videosListCollectionView.new(self, gamesList)
                self.videosListCollectionView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GameViewController,
            let game = sender as? Game {
            vc.mGameId = game.id
        }
    }
}
