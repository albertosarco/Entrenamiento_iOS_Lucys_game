//
//  VocalActivityDetailsCV.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 20/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import UIKit
import AVFoundation

class GameCardsCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate var mParentVC: GameViewController!
    fileprivate var mDataSet: [[Any]] = []
    fileprivate var mCurrentIndex: Int = 0
    // **must** define instance variable outside, because .play() will deallocate AVAudioPlayer
    // immediately and you won't hear a thing
    fileprivate var player: AVAudioPlayer?
    
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
        self.register(UINib(nibName: ReferenceCardItemCollectionViewCell.nibName, bundle: nil),
                      forCellWithReuseIdentifier: ReferenceCardItemCollectionViewCell.nibName)
        self.register(UINib(nibName: OptionCardItemCollectionViewCell.nibName, bundle: nil),
                      forCellWithReuseIdentifier: OptionCardItemCollectionViewCell.nibName)
        self.register(UINib(nibName: EmptyLayoutCVCell.nibName, bundle: nil),
                      forCellWithReuseIdentifier: EmptyLayoutCVCell.nibName)
    }
    
    public func new(_ vc: GameViewController, _ data: [[Any]]!, _ index: Int) {
        self.mParentVC = vc
        self.mDataSet += data
        self.mCurrentIndex = index
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mDataSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mDataSet[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let refrenceCard: ReferenceCard = mDataSet[indexPath.section][indexPath.row] as? ReferenceCard {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReferenceCardItemCollectionViewCell.nibName, for: indexPath)
                as! ReferenceCardItemCollectionViewCell
            
            cell.text.text = refrenceCard.name
            Utils.loadImageByFileURL(refrenceCard.imageName, Utils.getString(R.string.image_url, refrenceCard.imageName), cell.image)
            
            return cell
        } else if let optionCard: OptionCard = mDataSet[indexPath.section][indexPath.row] as? OptionCard {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCardItemCollectionViewCell.nibName, for: indexPath)
            as! OptionCardItemCollectionViewCell
        
            cell.text.text = optionCard.name
            Utils.loadImageByFileURL(optionCard.imageName, Utils.getString(R.string.image_url, optionCard.imageName), cell.image)
        
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: EmptyLayoutCVCell.nibName, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (mDataSet[indexPath.section][indexPath.row] is ReferenceCard) {
            return CGSize(width: self.frame.width - 10, height: 300)
        } else if (mDataSet[indexPath.section][indexPath.row] is OptionCard) {
            var multiplier = CGFloat(Int(self.frame.width / 90))
            if (Int(multiplier) > mDataSet[indexPath.section].count) {
                multiplier = CGFloat(mDataSet[indexPath.section].count)
            }
            let less = CGFloat(10 + ((multiplier - 1) * 5))
            return CGSize(width: ((self.frame.width / multiplier) - (less / multiplier)).rounded(.down), height: 121)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vocal = mDataSet[indexPath.section][indexPath.row] as? ReferenceCard {
            downloadFileAndPlaySound(Utils.getString(R.string.sound_url, vocal.soundName ?? ""), vocal.soundName ?? "")
        } else if let option = mDataSet[indexPath.section][indexPath.row] as? OptionCard {
            if (option.isCorrectOption) {
                playSound(Bundle.main.url(forResource: "winner", withExtension: "mp3")!)
                mParentVC.updateData(mCurrentIndex + 1)
            } else {
                downloadFileAndPlaySound(Utils.getString(R.string.sound_url, option.soundName), option.soundName)
            }
        }
    }
    
    fileprivate func downloadFileAndPlaySound(_ url : String, _ fileName: String) {
        if let audioUrl = URL(string: url) {
            // then lets create your document folder url
            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(fileName)
            //print(destinationUrl)
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                //print("The file already exists at path")
                playdownloadedSound(fileName)
                // if the file doesn't exist
            } else {
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        //print("File moved to documents folder")
                        self.playdownloadedSound(fileName)
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }).resume()
            }
        }
    }
    
    fileprivate func playdownloadedSound(_ fileName : String) {
        if let audioUrl = URL(string: fileName) {
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            playSound(destinationUrl)
        }
    }
    
    fileprivate func playSound(_ url: URL!) {
        do {
            if (url != nil) {
                try makeAppReadyToPlaySound()
                
                /// for iOS 11 onward, use :
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                
                // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
                player!.play()
            }
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    fileprivate func makeAppReadyToPlaySound() throws {
        /// this codes for making this app ready to takeover the device audio
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try AVAudioSession.sharedInstance().setActive(true)
    }
    
    func getItemCount() -> Int {
        return mDataSet.count + (mDataSet.count > 0 ? mDataSet[0].count : 0)
    }
    
    func setData(_ data: [[Any]]!, _ index: Int){
        mDataSet.removeAll()
        if (data != nil && !data.isEmpty) {
            mDataSet += data
        }
        mCurrentIndex = index
    }
}

class ReferenceCardItemCollectionViewCell: UICollectionViewCellAutoSize {
    
    fileprivate static let nibName: String = "ReferenceCardItem"
    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShape()
    }
}

class OptionCardItemCollectionViewCell: UICollectionViewCellAutoSize {
    
    public static let nibName: String = "OptionCardItem"
    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShape()
    }
}

class EmptyLayoutCVCell: UICollectionViewCell {
    public static let nibName: String = "EmptyLayout"
}
