//
//  VideosListCollectionView.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 21/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation
import UIKit

class VideosListCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate var mParentVC: UIViewController!
    fileprivate var mDataSet: [Game] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
        self.delegate = self
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            if #available(iOS 10.0, *) {
                flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            } else {
                flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
            }
        }
        self.register(UINib(nibName: VideosListItemCVCell.nibName, bundle: nil),
                      forCellWithReuseIdentifier: VideosListItemCVCell.nibName)
    }
    
    public func new(_ vc: UIViewController, _ data: [Game]!) {
        self.mParentVC = vc
        if (data != nil) {
            self.mDataSet += data
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mDataSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideosListItemCVCell.nibName, for: indexPath)
            as! VideosListItemCVCell
        
        cell.name.text = mDataSet[indexPath.row].name
        Utils.loadImageByFileURL(Utils.getString(R.string.youtube_thumbnail_hq_url, mDataSet[indexPath.row].videoId) , cell.videoThumbImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let multiplier = CGFloat(Int(self.frame.width / 310))
        let less = CGFloat(10 + ((multiplier - 1) * 5))
        return CGSize(width: ((self.frame.width / multiplier) - (less / multiplier)).rounded(.down), height: 181)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mParentVC.performSegue(withIdentifier: GameViewController.SEGUE_ID,
                               sender: mDataSet[indexPath.row])
    }
    
    func setData(_ data: [Game]!, _ index: Int){
        mDataSet.removeAll()
        if (data != nil && !data.isEmpty) {
            mDataSet += data
        }
    }
}

class VideosListItemCVCell: UICollectionViewCellAutoSize {
    
    fileprivate static let nibName: String = "VideosListItem"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var videoThumbImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShape()
    }
}
