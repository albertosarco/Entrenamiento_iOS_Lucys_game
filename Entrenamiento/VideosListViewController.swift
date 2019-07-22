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
    
    fileprivate var mWaitPlease: DialogWaitPleaseVC!
    fileprivate var mIsInitialLoad: Bool = true
    fileprivate var gamesList: [Game]?
    fileprivate var reachability : Reachability!
    
    private func observeReachability() {
        self.reachability = Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged),
                                               name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        } catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        if (reachability.connection == .cellular || reachability.connection == .wifi) {
            viewDidAppear(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeReachability()
        
        if (mWaitPlease == nil) {
            mWaitPlease = DialogWaitPleaseVC.show(self, Utils.getString(R.string.wait_please))
        }
        
        DispatchQueue.global(qos: .background).async(execute: {
            self.gamesList = GameData.getAllGames()
            
            DispatchQueue.main.sync {
                self.videosListCollectionView.new(self, self.gamesList)
                self.videosListCollectionView.reloadData()
                
                self.showOrHideEmptyLayout()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if (mIsInitialLoad) {
            mIsInitialLoad = false
        } else if (gamesList == nil) {
            if (mWaitPlease == nil) {
                mWaitPlease = DialogWaitPleaseVC.show(self, Utils.getString(R.string.wait_please))
            }
            
            DispatchQueue.global(qos: .background).async(execute: {
                self.gamesList = GameData.getAllGames()
                self.videosListCollectionView.setData(self.gamesList)
                
                DispatchQueue.main.sync {
                    self.videosListCollectionView.reloadData()
                    
                    self.showOrHideEmptyLayout()
                }
            })
        }
    }
    
    fileprivate func showOrHideEmptyLayout() {
        if (videosListCollectionView.getItemCount() > 0) {
            videosListCollectionView.removeEmptyMessage()
        } else {
            videosListCollectionView.setEmptyMessage(Utils.getString(R.string.empty_screen))
        }
        
        if (self.mWaitPlease != nil) {
            self.mWaitPlease.dismiss(animated: true, completion: {
                self.mWaitPlease = nil
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GameViewController,
            let game = sender as? Game {
            vc.mGameId = game.id
        }
    }
}
