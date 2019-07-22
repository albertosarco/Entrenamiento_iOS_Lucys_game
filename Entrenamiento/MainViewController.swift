//
//  MainViewController.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 19/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Juegos de Lucy"
        
//        if #available(iOS 10.0, *) {
//            self.navigationController?.navigationBar.topItem?.backBarButtonItem?.title = "Volver"
//        } else {
//            self.navigationItem.leftItemsSupplementBackButton = true
//            self.navigationController?.navigationBar.topItem?.title = "Volver"
//        }
        
        self.welcomeLabel.text = "!Bienvenido a los juegos de Lucy!"
        self.startButton.setTitle("Empezar", for: .normal)
    }
}
