//
//  OptionCard.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 20/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

struct OptionCard: Codable  {
    
    var name: String!
    var imageName: String!
    var soundName: String!
    var isCorrectOption: Bool!
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageName
        case soundName
        case isCorrectOption = "correctOption"
    }
}
