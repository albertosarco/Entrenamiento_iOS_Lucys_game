//
//  GameStage.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 21/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

public struct GameStage: Codable  {
    
    var referenceCard: ReferenceCard!
    var optionCards: [OptionCard]!
    
    private enum CodingKeys: String, CodingKey {
        case referenceCard
        case optionCards
    }
}
