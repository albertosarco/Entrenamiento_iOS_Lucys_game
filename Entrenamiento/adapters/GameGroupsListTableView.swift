//
//  OptionsListTableView.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 19/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation
import UIKit

class GameGroupsListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate var mParentVC: UIViewController!
    fileprivate var mDataSet: [GameGroup] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.register(UINib(nibName: GameGroupsListItemTableViewCell.nibName, bundle: nil),
                      forCellReuseIdentifier: GameGroupsListItemTableViewCell.nibName)
        self.dataSource = self
        self.delegate = self
        // estas dos ultimas lineas son para que se cambie automaticamente la altura de la fila
        self.rowHeight = UITableView.automaticDimension
        // importante que tenga el mismo tamano declarado en el .xib
        self.estimatedRowHeight = 100
    }
    
    public func new(_ vc: UIViewController, _ data: [GameGroup]!) {
        self.mParentVC = vc
        if (data != nil && !data.isEmpty) {
            self.mDataSet += data
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mDataSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameGroupsListItemTableViewCell.nibName, for: indexPath)
            as! GameGroupsListItemTableViewCell
        
        cell.name.text = mDataSet[indexPath.row].name
        Utils.loadImageByFileURL(Utils.getString(R.string.youtube_thumbnail_hq_url, mDataSet[indexPath.row].imageName ?? ""), cell.imageIcon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        mParentVC.performSegue(withIdentifier: GamesListViewController.SEGUE_ID,
                               sender: mDataSet[indexPath.row])
    }
    
    func getItemCount() -> Int {
        return mDataSet.count
    }
}

class GameGroupsListItemTableViewCell: UITableViewCell {
    
    fileprivate static let nibName: String = "GameGroupsListItem"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }
}
