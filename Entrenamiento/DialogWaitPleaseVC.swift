//
//  DialogWaitPleaseVC.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 22/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import UIKit

class DialogWaitPleaseVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var message: UILabel!
    
    public static func show(_ parentVC: UIViewController, _ message: String!) -> DialogWaitPleaseVC! {
        if let dialogWaitPleaseVC = Bundle.main.loadNibNamed("DialogWaitPlease", owner: self, options: nil)![0]
            as? DialogWaitPleaseVC {
            dialogWaitPleaseVC.message.text = message
            parentVC.present(dialogWaitPleaseVC, animated: true, completion: nil)
            return dialogWaitPleaseVC
        }
        return nil
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
    
    public func cancel() {
        self.dismiss(animated: false, completion: nil)
    }
}
