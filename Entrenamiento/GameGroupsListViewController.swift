//
//  GameGroupsListViewController.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 19/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation
import UIKit

class GameGroupsListViewController: UIViewController {
    
    @IBOutlet weak var optionsListTableView: GameGroupsListTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        DispatchQueue.global(qos: .background).async(execute: {
            let gameGroupsList = GameData.getGameGroupsList()
            
            DispatchQueue.main.sync {
                self.optionsListTableView.new(self, gameGroupsList)
                self.optionsListTableView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GamesListViewController,
            let gameGroup = sender as? GameGroup {
            vc.mGameGroup = gameGroup
        }
    }
}
