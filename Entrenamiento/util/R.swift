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
    let lateral_menu_bg_color = UIColor(ResourceIntKey.init(0xFEFEFE))
    let label_color = UIColor(ResourceIntKey.init(0x222222))
    let dark_grey = UIColor(ResourceIntKey.init(0x777777))
    let grey = UIColor(ResourceIntKey.init(0xCCCCCC))
    let grey_medium = UIColor(ResourceIntKey.init(0xDDDDDD))
    let light_grey = UIColor(ResourceIntKey.init(0xEEEEEE))
    let transparent_light_grey = UIColor(ResourceIntKey.init(0xEEEEEE))
    let separator_color = UIColor(ResourceIntKey.init(0xEEEEEE))
    let golden_light = UIColor(ResourceIntKey.init(0xFFD859))
    let golden = UIColor(ResourceIntKey.init(0xFFC400))
    let golden_medium = UIColor(ResourceIntKey.init(0xFFD700))
    let black = UIColor(ResourceIntKey.init(0x444444))
    let phoneNumberLinkColor = UIColor(ResourceIntKey.init(0x0099CC))
    let emailLinkColor = UIColor(ResourceIntKey.init(0x222222))
    let colorQtyOrderedError = UIColor(ResourceIntKey.init(0xE53935))
    let golden_button_text_color = UIColor(ResourceIntKey.init(0x555555))
    let grey_100 = UIColor(ResourceIntKey.init(0xF5F5F5))
    let grey_600 = UIColor(ResourceIntKey.init(0x757575))
    let grey_800 = UIColor(ResourceIntKey.init(0x424242))
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
