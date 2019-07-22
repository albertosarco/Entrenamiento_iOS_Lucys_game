//
//  Toast.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 23/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import UIKit

class Toast {
    
    /**
     * Show the view or text notification for a short period of time.  This time
     * could be user-definable.  This is the default.
     * @see #setDuration
     */
    public static let LENGTH_SHORT: Double = 2.2
    
    /**
     * Show the view or text notification for a long period of time.  This time
     * could be user-definable.
     * @see #setDuration
     */
    public static let LENGTH_LONG: Double = 4.4
    
    static func makeText(_ parentVC: UIViewController, _ text: String, _ duration: Double) {
        let toastLabel = UILabel(frame: CGRect(x: 17, y: parentVC.view.frame.size.height-100,
                                               width: parentVC.view.frame.size.width - 34, height: 50))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.text = text
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        parentVC.view.addSubview(toastLabel)
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
