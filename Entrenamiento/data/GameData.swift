//
//  GameData.swift
//  Entrenamiento
//
//  Created by Jesus Alberto Sarco Giannini on 21/07/2019.
//  Copyright © 2019 Smart Builders C.A. All rights reserved.
//

import Foundation

public class GameData {
    
    public static func getGameGroupsList() -> [GameGroup]! {
        do {
            let data = try consume("getGameGroupsPost", nil, "POST", "application/json;charset=UTF-8")
            return try JSONDecoder().decode([GameGroup].self, from: data)
        } catch let error {
            print(error)
        }
        return []
    }
    
    public static func getGameById(_ gameId: Int) -> Game {
        if (gameId == 1) {
            return Game(id: gameId,
                        name: "Juego 1",
                        stagesList: getGameStagesListById(gameId),
                        videoId: "JycXUQx9Nik",
                        videoThumbnailUrl: Utils.getString(R.string.youtube_thumbnail_hq_url, "JycXUQx9Nik"))
        }
        return Game(id: gameId,
                    name: "Juego \(gameId)",
                    stagesList: getGameStagesListById(gameId),
                    videoId: "JycXUQx9Nik",
                    videoThumbnailUrl: Utils.getString(R.string.youtube_thumbnail_hq_url, "JycXUQx9Nik"))
    }
    
    public static func getGameStagesListById(_ gameId: Int) -> [GameStage]! {
        let stagesList: [GameStage] = [
            GameStage(referenceCard: ReferenceCard(name: "Vocal A", imageIcon: #imageLiteral(resourceName: "reference_a"), soundName: "letra_A"),
                      optionCards: [OptionCard(name: "A - a", imageIcon: #imageLiteral(resourceName: "reference_a"), soundName: "incorrecto_A", isCorrectOption: true),
                                    OptionCard(name: "E - e", imageIcon: #imageLiteral(resourceName: "reference_e"), soundName: "incorrecto_E", isCorrectOption: false),
                                    OptionCard(name: "I - i", imageIcon: #imageLiteral(resourceName: "reference_i"), soundName: "incorrecto_I", isCorrectOption: false),
                                    OptionCard(name: "O - o", imageIcon: #imageLiteral(resourceName: "reference_o"), soundName: "incorrecto_O", isCorrectOption: false),
                                    OptionCard(name: "U - u", imageIcon: #imageLiteral(resourceName: "reference_u"), soundName: "incorrecto_U", isCorrectOption: false)]),
            GameStage(referenceCard: ReferenceCard(name: "Vocal E", imageIcon: #imageLiteral(resourceName: "reference_e"), soundName: "letra_E"),
                      optionCards: [OptionCard(name: "A - a", imageIcon: #imageLiteral(resourceName: "reference_a"), soundName: "incorrecto_A", isCorrectOption: false),
                                    OptionCard(name: "E - e", imageIcon: #imageLiteral(resourceName: "reference_e"), soundName: "incorrecto_E", isCorrectOption: true),
                                    OptionCard(name: "I - i", imageIcon: #imageLiteral(resourceName: "reference_i"), soundName: "incorrecto_I", isCorrectOption: false),
                                    OptionCard(name: "O - o", imageIcon: #imageLiteral(resourceName: "reference_o"), soundName: "incorrecto_O", isCorrectOption: false),
                                    OptionCard(name: "U - u", imageIcon: #imageLiteral(resourceName: "reference_u"), soundName: "incorrecto_U", isCorrectOption: false)]),
            GameStage(referenceCard: ReferenceCard(name: "Vocal I", imageIcon: #imageLiteral(resourceName: "reference_i"), soundName: "letra_I"),
                      optionCards: [OptionCard(name: "A - a", imageIcon: #imageLiteral(resourceName: "reference_a"), soundName: "incorrecto_A", isCorrectOption: false),
                                    OptionCard(name: "E - e", imageIcon: #imageLiteral(resourceName: "reference_e"), soundName: "incorrecto_E", isCorrectOption: false),
                                    OptionCard(name: "I - i", imageIcon: #imageLiteral(resourceName: "reference_i"), soundName: "incorrecto_I", isCorrectOption: true),
                                    OptionCard(name: "O - o", imageIcon: #imageLiteral(resourceName: "reference_o"), soundName: "incorrecto_O", isCorrectOption: false),
                                    OptionCard(name: "U - u", imageIcon: #imageLiteral(resourceName: "reference_u"), soundName: "incorrecto_U", isCorrectOption: false)]),
            GameStage(referenceCard: ReferenceCard(name: "Vocal O", imageIcon: #imageLiteral(resourceName: "reference_o"), soundName: "letra_O"),
                      optionCards: [OptionCard(name: "A - a", imageIcon: #imageLiteral(resourceName: "reference_a"), soundName: "incorrecto_A", isCorrectOption: false),
                                    OptionCard(name: "E - e", imageIcon: #imageLiteral(resourceName: "reference_e"), soundName: "incorrecto_E", isCorrectOption: false),
                                    OptionCard(name: "I - i", imageIcon: #imageLiteral(resourceName: "reference_i"), soundName: "incorrecto_I", isCorrectOption: false),
                                    OptionCard(name: "O - o", imageIcon: #imageLiteral(resourceName: "reference_o"), soundName: "incorrecto_O", isCorrectOption: true),
                                    OptionCard(name: "U - u", imageIcon: #imageLiteral(resourceName: "reference_u"), soundName: "incorrecto_U", isCorrectOption: false)]),
            GameStage(referenceCard: ReferenceCard(name: "Vocal U", imageIcon: #imageLiteral(resourceName: "reference_u"), soundName: "letra_U"),
                      optionCards: [OptionCard(name: "A - a", imageIcon: #imageLiteral(resourceName: "reference_a"), soundName: "incorrecto_A", isCorrectOption: false),
                                    OptionCard(name: "E - e", imageIcon: #imageLiteral(resourceName: "reference_e"), soundName: "incorrecto_E", isCorrectOption: false),
                                    OptionCard(name: "I - i", imageIcon: #imageLiteral(resourceName: "reference_i"), soundName: "incorrecto_I", isCorrectOption: false),
                                    OptionCard(name: "O - o", imageIcon: #imageLiteral(resourceName: "reference_o"), soundName: "incorrecto_O", isCorrectOption: false),
                                    OptionCard(name: "U - u", imageIcon: #imageLiteral(resourceName: "reference_u"), soundName: "incorrecto_U", isCorrectOption: true)])]
        return stagesList
    }
    
    public static func getAllGames() -> [Game]! {
        let gamesList = [getGameById(1), getGameById(2), getGameById(3), getGameById(4), getGameById(5), getGameById(6)]
        return gamesList
    }
    
    public static func getGamesByGroupId(_ groupId: Int!) -> [Game]! {
        let gamesList = [getGameById(1), getGameById(2), getGameById(3), getGameById(4), getGameById(5), getGameById(6)]
        return gamesList
    }
    
    private static func consume(_ urlString: String, _ httpBody: String!, _ httpMethod: String, _ contentType: String) throws -> Data {
        let connectionTimeOutInSeconds: Double = 60
        
        var request = URLRequest(url: URL(string: Utils.getString(R.string.server_url, urlString))!)
        request.timeoutInterval = connectionTimeOutInSeconds
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = httpMethod
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")

        if (httpBody != nil) {
            request.httpBody = httpBody.data(using: .utf8)
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = connectionTimeOutInSeconds
        sessionConfig.timeoutIntervalForResource = connectionTimeOutInSeconds
        let (data, response) = try URLSession(configuration: sessionConfig).synchronousDataTask(with: request)
        
        //se verifica el estatus de la respuesta
        if (response?.statusCode != 200) {
            if (response?.statusCode == 401) { //HTTP_UNAUTHORIZED
                throw String(data: data!, encoding: String.Encoding.utf8) ?? ""
            } else if (response?.statusCode == 404) { //
                throw "server not found"
            } else {
                throw String(data: data!, encoding: String.Encoding.utf8) ?? ""
            }
        }
        return data!
    }
}

extension URLSession {
    
    func synchronousDataTask(with request: URLRequest) throws -> (data: Data?, response: HTTPURLResponse?) {
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var responseData: Data?
        var theResponse: URLResponse?
        var theError: Error?
        
        dataTask(with: request) { (data, response, error) -> Void in
            
            responseData = data
            theResponse = response
            theError = error
            
            semaphore.signal()
            
            }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        if let error = theError {
            throw error
        }
        
        return (data: responseData, response: theResponse as! HTTPURLResponse?)
    }
}
