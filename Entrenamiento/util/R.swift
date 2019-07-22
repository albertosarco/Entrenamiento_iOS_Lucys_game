//
//  R.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 20/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation
import UIKit

class R {
    static let string: string = .init()
    static let color: color = .init()
}

class string {
    let youtube_thumbnail_hq_url: ResourceStringKey = .init("youtube_thumbnail_hq_url")
    let server_url: ResourceStringKey = .init("server_url")
    let image_url: ResourceStringKey = .init("image_url")
}

class color {
    let colorPrimary = UIColor(ResourceStringKey.init("colorPrimary"))
    let colorPrimaryMedium = UIColor(ResourceStringKey.init("colorPrimaryMedium"))
    let colorPrimaryLight = UIColor(ResourceStringKey.init("colorPrimaryLight"))
    let colorPrimaryDark = UIColor(ResourceStringKey.init("colorPrimaryDark"))
    let colorAccent = UIColor(ResourceStringKey.init("colorAccent"))
    let colorAccentMedium = UIColor(ResourceStringKey.init("colorAccentMedium"))
    let textColorPrimary = UIColor(ResourceStringKey.init("textColorPrimary"))
    let textColorAccent = UIColor(ResourceStringKey.init("textColorAccent"))
    let title_background_color = UIColor(ResourceStringKey.init("title_background_color"))
    
    //globales
    let grey_medium = UIColor(ResourceIntKey.init(0xDDDDDD))
}

public class ResourceStringKey {
    var key: String
    init(_ key: String) {
        self.key = key
    }
}

public class ResourceIntKey {
    var key: Int
    init(_ key: Int) {
        self.key = key
    }
}
