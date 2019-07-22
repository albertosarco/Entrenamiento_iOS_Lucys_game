//
//  DialogCongratsViewController.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 20/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class DialogCongratsViewController: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var buttonPrize: UIButton!
    @IBOutlet weak var youTubePlayerView: YTPlayerView!
    
    fileprivate var mParentVC: UIViewController!
    fileprivate var videoId: String?
    
    public static func newInstance(_ parentVC: UIViewController, _ videoId: String!) -> DialogCongratsViewController! {
        if let dialogCongratsVC = Bundle.main.loadNibNamed("DialogCongrats", owner: self, options: nil)![0]
            as? DialogCongratsViewController {
            dialogCongratsVC.mParentVC = parentVC
            dialogCongratsVC.message.text = "¡Felicidades!"
            dialogCongratsVC.buttonPrize.setTitle("Reclamar Premio", for: .normal)
            dialogCongratsVC.videoId = videoId
            return dialogCongratsVC
        }
        return nil
    }
    
    public func show() {
        mParentVC.present(self, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    fileprivate func setupView() {
        self.containerView.layer.cornerRadius = 4
    }
    
    fileprivate func animateView() {
        self.containerView.alpha = 0
        self.containerView.frame.origin.y = self.containerView.frame.origin.y + 50
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.containerView.alpha = 1.0
            self.containerView.frame.origin.y = self.containerView.frame.origin.y - 50
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first, touch.view != containerView {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    public func cancel() {
        self.dismiss(animated: true, completion: {
            
            self.mParentVC.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func buttonPrizeAction(_ sender: Any) {
        youTubePlayerView.delegate = self
        youTubePlayerView.load(withVideoId: videoId ?? "",
                               playerVars: ["controls": 0, "playsinline": 1, "autohide": 1, "showinfo": 0, "autoplay": 1, "modestbranding": 1, "rel": 0])
        youTubePlayerView.isHidden = false
        containerView.isHidden = true
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        //print("Ready")
        playerView.playVideo()
        playerView.webView?.allowsInlineMediaPlayback = false
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        //print("Changed to state: \(state)")
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo quality: YTPlaybackQuality) {
        //print("Changed to quality: \(quality)")
    }
    
    private func playerView(_ playerView: YTPlayerView, receivedError error: Error) {
        //print("Error: \(error)")
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime time: Float) {
        //print("Play time: \(time)")
    }
    
}
