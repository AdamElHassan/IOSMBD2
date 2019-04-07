//
//  ApiController.swift
//  SocialApp
//
//  Created by esper van den heuvel on 22-03-19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class ApiLoginController {
    
    private var user : LoginUserData?
    
    func makeRequest(url: String, httpMethode: String, data: [String: Any]) -> URLRequest! {
        guard let url = URL(string: "https://blankapi.herokuapp.com/" + url	) else {
            print("Error: cannot create URL")
            return nil
        }
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethode
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let loginData: [String: Any] = data
        let json: Data
        do {
            json = try JSONSerialization.data(withJSONObject: loginData, options: [])
            urlRequest.httpBody = json
        } catch {
            print("Error: cannot create JSON from loginData")
            return nil
        }
        return urlRequest
    }
    
    func login(username: String, password: String, completionHandler: @escaping (_ user: LoginUserData?) -> ()) {
        let data = ["username": username, "password": password]
        let urlRequest = self.makeRequest(url: "login", httpMethode: "POST", data: data)
        if (urlRequest != nil) {
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest!) {
                (data, response, error) in
                if let data = data {
                    do{
                        let decoder = JSONDecoder()
                        let userData = try decoder.decode(LoginUserData.self, from: data)
                        DispatchQueue.main.async {
                            completionHandler(userData)
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
    func setLogo(number: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        if let url = URL( string:"https://api.adorable.io/avatars/285/abott"+number+"@adorable.png")
        {
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf:url)
                {
                    DispatchQueue.main.async {
                        completionHandler(data)
                        
                    }
                }
            }
        }
    }
}

