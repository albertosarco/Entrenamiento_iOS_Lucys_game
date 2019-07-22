//
//  GameGroup.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 19/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

public struct GameGroup: Codable {
    
    var id: Int!
    var name: String!
    var imageName: String!
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageName
    }
}
