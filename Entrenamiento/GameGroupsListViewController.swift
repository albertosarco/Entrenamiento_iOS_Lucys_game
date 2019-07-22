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
    
    @IBOutlet weak var gameGroupsListTableView: GameGroupsListTableView!
    
    fileprivate var mWaitPlease: DialogWaitPleaseVC!
    fileprivate var mIsInitialLoad: Bool = true
    fileprivate var gameGroupsList: [GameGroup]?
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
            self.gameGroupsList = GameData.getGameGroupsList()
            
            DispatchQueue.main.sync {
                self.gameGroupsListTableView.new(self, self.gameGroupsList)
                self.gameGroupsListTableView.reloadData()
                
                self.showOrHideEmptyLayout()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if (mIsInitialLoad) {
            mIsInitialLoad = false
        } else if (gameGroupsList == nil) {
            if (mWaitPlease == nil) {
                mWaitPlease = DialogWaitPleaseVC.show(self, Utils.getString(R.string.wait_please))
            }
            
            DispatchQueue.global(qos: .background).async(execute: {
                self.gameGroupsList = GameData.getGameGroupsList()
                self.gameGroupsListTableView.setData(self.gameGroupsList)
                
                DispatchQueue.main.sync {
                    self.gameGroupsListTableView.reloadData()
                    
                    self.showOrHideEmptyLayout()
                }
            })
        }
    }
    
    fileprivate func showOrHideEmptyLayout() {
        if (gameGroupsListTableView.getItemCount() > 0) {
            gameGroupsListTableView.removeEmptyMessage()
        } else {
            gameGroupsListTableView.setEmptyMessage(Utils.getString(R.string.empty_screen))
        }
        
        if (self.mWaitPlease != nil) {
            self.mWaitPlease.dismiss(animated: true, completion: {
                self.mWaitPlease = nil
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GamesListViewController,
            let gameGroup = sender as? GameGroup {
            vc.mGameGroup = gameGroup
        }
    }
}
