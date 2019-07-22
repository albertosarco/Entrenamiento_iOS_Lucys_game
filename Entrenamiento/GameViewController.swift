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
    fileprivate var mWaitPlease: DialogWaitPleaseVC!
    fileprivate var mGame: Game?
    fileprivate var mDataSet: [[[Any]]] = [[[]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cargando juego..."
        self.removeBackButtonText()
        
//        if (mWaitPlease == nil) {
//            mWaitPlease = DialogWaitPleaseVC.show(self, Utils.getString(R.string.wait_please))
//        }
        
        DispatchQueue.global(qos: .background).async(execute: {
            self.loadData()
            
            DispatchQueue.main.sync {
                self.navigationItem.title = self.mGame?.name
                
                self.gameCardsCollectionView.new(self, self.mDataSet.count > 0 ? self.mDataSet[0] : nil, 0)
                self.gameCardsCollectionView.reloadData()
                
                self.showOrHideEmptyLayout()
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
//            if (mWaitPlease == nil) {
//                mWaitPlease = DialogWaitPleaseVC.show(self, Utils.getString(R.string.wait_please))
//            }
            
            DispatchQueue.global(qos: .background).async(execute: {
                self.gameCardsCollectionView.setData(self.mDataSet[index], index)

                DispatchQueue.main.sync {
                    self.gameCardsCollectionView.reloadData()
                    
                    self.showOrHideEmptyLayout()
                }
            })
        } else {
            DialogCongratsViewController.newInstance(self, mGame?.videoId).show()
        }
    }
    
    fileprivate func showOrHideEmptyLayout() {
        if (gameCardsCollectionView.getItemCount() > 0) {
            gameCardsCollectionView.removeEmptyMessage()
        } else {
            gameCardsCollectionView.setEmptyMessage(Utils.getString(R.string.empty_screen))
        }
        
        if (self.mWaitPlease != nil) {
            self.mWaitPlease.dismiss(animated: true, completion: {
                self.mWaitPlease = nil
            })
        }
    }
}
