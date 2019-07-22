//
//  GameData.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 21/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation

public class GameData {
    
    public static func getGameGroupsList() -> [GameGroup]? {
        do {
            let data = try Utils.consumeWebService("getGameGroupsList")
            return try JSONDecoder().decode([GameGroup].self, from: data)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    public static func getGameById(_ gameId: Int) -> Game? {
        do {
            let data = try Utils.consumeWebService("getGameById?gameId=\(gameId)")
            return try JSONDecoder().decode(Game.self, from: data)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    public static func getGameStagesListById(_ gameId: Int) -> [GameStage]? {
        do {
            let data = try Utils.consumeWebService("getGameStagesListById?gameId=\(gameId)")
            return try JSONDecoder().decode([GameStage].self, from: data)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    public static func getAllGames() -> [Game]? {
        do {
            let data = try Utils.consumeWebService("getAllGames")
            return try JSONDecoder().decode([Game].self, from: data)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    public static func getGamesByGroupId(_ groupId: Int) -> [Game]? {
        do {
            let data = try Utils.consumeWebService("getGamesByGroupId?groupId=\(groupId)")
            return try JSONDecoder().decode([Game].self, from: data)
        } catch let error {
            print(error)
        }
        return nil
    }
}


