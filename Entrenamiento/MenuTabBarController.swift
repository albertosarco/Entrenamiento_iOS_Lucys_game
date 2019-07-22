//
//  MenuTabBarController.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 21/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import UIKit

class MenuTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Juegos de Lucy"
        self.removeBackButtonText()
        
        self.tabBar.items?[0].title = "Juegos"
        self.tabBar.items?[1].title = "Vídeos"
    }
}
