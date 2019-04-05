//
//  APIGroupsController.swift
//  SocialApp
//
//  Created by Adam el Hassan on 23/03/2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class ApiGamesController {
    
    private var games : [GameData]!
    
    func makeRequest(url: String, httpMethode: String, data: [String: Any]?) -> URLRequest! {
        guard let url = URL(string: "https://blankapi.herokuapp.com/" + url) else {
            print("Error: cannot create URL")
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethode
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        if(data != nil && httpMethode == "POST"){
//
//            let json: Data
//            do {
//                json = try JSONSerialization.data(withJSONObject: data!, options: [])
//                urlRequest.httpBody = json
//            } catch {
//                print("Error: cannot create JSON from loginData")
//                return nil
//            }
//        }
        return urlRequest
    }
    
    func getGames( completionHandler: @escaping (_ games: [GameData]?) -> ()) {
        let urlRequest = self.makeRequest(url: "games", httpMethode: "GET", data: nil)
        if (urlRequest != nil) {
            let session = URLSession.shared
            let decoder = JSONDecoder()
            let task = session.dataTask(with: urlRequest!) {
                (data, response, error) in
                
                if let data = data {
                    do{
                        let games = try decoder.decode([GameData].self, from: data)
                        DispatchQueue.main.async {
                            completionHandler(games)
                        }
                    }
                    catch {
                        
                    }
                }
            }
            task.resume()
        }
    }
    
//    func joinGroup(group: String, role: Int, completionHandler: @escaping (_ group: UserGroupArrayData?, _ error: ErrorData?) -> ()) {
//        let data = ["group": group, "role": role] as [String : Any]
//        let urlRequest = self.makeRequest(url: "usergroups", httpMethode: "POST", data: data)
//        if (urlRequest != nil) {
//            let session = URLSession.shared
//            let decoder = JSONDecoder()
//            let task = session.dataTask(with: urlRequest!) {
//                (data, response, error) in
//                if let data = data {
//                    do{
//                        let userGroup = try decoder.decode(UserGroupArrayData.self, from: data)
//                        DispatchQueue.main.async {
//                            completionHandler(userGroup, nil)
//                        }
//                    } catch {
//                        do {
//                            let messageData = try decoder.decode(ErrorData.self, from: data)
//                            DispatchQueue.main.async {
//                                completionHandler(nil, messageData)
//                            }
//                        }
//                        catch {
//                            print("Something went wrong while decoding errormessages")
//                        }
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
}
