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
    
    @IBAction func cleanSavedImagesAction(_ sender: Any) {        
        let alert = UIAlertController(title: nil, message: Utils.getString(R.string.clean_images_dir),
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Utils.getString(R.string.yes), style: .default,
                                      handler: { action in alert.dismiss(animated: true, completion: nil)
                                        let waitPlease = DialogWaitPleaseVC.show(self, Utils.getString(R.string.deleting_images_wait_please))
                                        var folderDeleted: Bool = false
                                        
                                        DispatchQueue.global(qos: .background).async(execute: {
                                            folderDeleted = Utils.deleteImagesFolder()
                                            
                                            DispatchQueue.main.sync {
                                                waitPlease?.dismiss(animated: true, completion: {
                                                    if (folderDeleted) {
                                                        Toast.makeText(self, Utils.getString(R.string.folder_removed_successfully), Toast.LENGTH_SHORT)
                                                    } else {
                                                        Toast.makeText(self, Utils.getString(R.string.folder_was_not_removed), Toast.LENGTH_SHORT)
                                                    }
                                                })
                                            }
                                        })
        }))
        alert.addAction(UIAlertAction(title: Utils.getString(R.string.no), style: .destructive,
                                      handler: { action in }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
