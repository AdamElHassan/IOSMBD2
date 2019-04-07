//
//  APIGroupsController.swift
//  SocialApp
//
//  Created by Adam el Hassan on 23/03/2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class ApiGamesController {
    
    private var games : GamesData!
    private var game : GameData!
    
    func makeRequest(url: String, httpMethode: String, data: [String: String]?) -> URLRequest! {
        guard let url = URL(string: "https://blankapi.herokuapp.com/" + url) else {
            print("Error: cannot create URL")
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethode
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // You only want to add body to the api call if it is a post request.
        if(data != nil && httpMethode == "POST"){
            let json: Data
            do {
                json = try JSONSerialization.data(withJSONObject: data ?? [], options: [])
                urlRequest.httpBody = json
            } catch {
                print("Error: cannot create JSON from loginData")
                return nil
            }
        
        
        }
        return urlRequest
    }
    
    func createGame(status: String, completionHandler: @escaping (_ game: GameData?) -> ()) {
        let data = ["status": status]
        let urlRequest = self.makeRequest(url: "games", httpMethode: "POST", data: data)
        if (urlRequest != nil) {
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest!) {
                (data, response, error) in
                if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        let game = try decoder.decode(GameData.self, from: data)
                        DispatchQueue.main.async {
                            completionHandler(game)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            //todo: check if API is ofline and give different error
                            completionHandler(nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func getGames( completionHandler: @escaping (_ games: GamesData?) -> ()) {
        let urlRequest = self.makeRequest(url: "games", httpMethode: "GET", data: nil)
        if (urlRequest != nil) {
            let session = URLSession.shared
            let decoder = JSONDecoder()
            let task = session.dataTask(with: urlRequest!) {
                (data, response, error) in
                
                if let data = data {
                    do{
                        let games = try decoder.decode(GamesData.self, from: data)
                        DispatchQueue.main.async {
                            completionHandler(games)
                        }
                    }
                    catch {
                        DispatchQueue.main.async {
                            //todo: check if API is ofline and give different error
                            completionHandler(nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
