//
//  GamesListViewController.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 21/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation
import UIKit

class GamesListViewController: UIViewController {
    
    public static let SEGUE_ID: String = "SegueGamesListVC"
    
    @IBOutlet weak var gamesListCollectionView: GamesListCollectionView!
    
    public var mGameGroup: GameGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Juegos de: \(self.mGameGroup?.name ?? "")"
        self.removeBackButtonText()
        
        DispatchQueue.global(qos: .background).async(execute: {
            let gamesList = GameData.getGamesByGroupId(self.mGameGroup?.id ?? 0)
            
            DispatchQueue.main.sync {
                if (gamesList != nil && gamesList?.count ?? 0 > 0) {
                    self.gamesListCollectionView.new(self, gamesList)
                    self.gamesListCollectionView.reloadData()
                }
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
