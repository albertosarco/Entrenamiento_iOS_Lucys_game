//
//  GameCardsViewController.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 20/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    public static let SEGUE_ID: String = "SegueGameVC"
    
    @IBOutlet weak var gameCardsCollectionView: GameCardsCollectionView!
    
    public var mGameId: Int!
    fileprivate var mGame: Game?
    fileprivate var mDataSet: [[[Any]]] = [[[]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cargando juego..."
        self.removeBackButtonText()
        
        DispatchQueue.global(qos: .background).async(execute: {
            self.loadData()
            let dataSet = self.getData(0)
            
            DispatchQueue.main.sync {
                self.navigationItem.title = self.mGame?.name
                
                self.gameCardsCollectionView.new(self, dataSet, 0)
                self.gameCardsCollectionView.reloadData()
            }
        })
    }
    
    fileprivate func loadData() {
        if (mGameId != nil) {
            mGame = GameData.getGameById(mGameId)
            if let stagesList: [GameStage] = mGame?.stagesList {
                for gameStage in stagesList {
                    let index = self.mDataSet.count - 1
                    
                    self.mDataSet[index].append([])
                    self.mDataSet[index][0].append(gameStage.referenceCard!)
                    
                    self.mDataSet[index].append([])
                    for gameOption in gameStage.optionCards! {
                        self.mDataSet[index][1].append(gameOption)
                    }
                    
                    if (self.mDataSet.count < stagesList.count) {
                        self.mDataSet.append([[]])
                    }
                }
            }
        }
    }
    
    func updateData(_ index: Int) {
        if (index < self.mDataSet.count) {
            DispatchQueue.global(qos: .background).async(execute: {
                self.gameCardsCollectionView.setData(self.getData(index), index)

                DispatchQueue.main.sync {
                    self.gameCardsCollectionView.reloadData()
                }
            })
        } else {
            DialogCongratsViewController.newInstance(self, mGame?.videoId).show()
        }
    }
    
    fileprivate func getData(_ index: Int) -> [[Any]] {
        return mDataSet[index]
    }
}
