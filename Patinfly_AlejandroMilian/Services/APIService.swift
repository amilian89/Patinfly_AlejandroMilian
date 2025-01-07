//
//  APIService.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 3/1/25.
//

import Foundation

class APIService{
    static let shared = APIService()
    
    enum APIError: Error{
        case error
    }
    
    func validUser(credentials: Credentials) -> Bool{
        return (credentials.email == "alejandro@gmail.com" && credentials.password == "password")
    }
    
    func login(credentials: Credentials,
               completition: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            if self.validUser(credentials: credentials){
                completition(.success(true))
            }
            else{
                completition(.failure(.invalidCredentials))
            }
        }
    }
    
    //Metodos para poder implementar 2 Práctica server
        
        static func checkServerStatus(){
            let callURL = APIAccess.serverStatus()
            let task = URLSession.shared.dataTask(with:callURL.url!){
                (data, response, error) in
                guard let data = data else{
                    print("APIService: error accessing server status")
                    return
                }
                
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    print("Server response: 3xx, 4xx or 5xx")
                    return
                }
                
                do {
                    print(data)
                    let jsonData = try JSONDecoder().decode(ServerStatus.self, from: data)
                    scooterList(withToken: APIAccess.token)
                    print(jsonData)

                }catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                }
                 
            }
            task.resume()
        }
        
        static func checkServerStatusWithCompletion(completion: @escaping (Result<ServerStatus, NetworkError>) -> Void){
            let callURL = APIAccess.serverStatus()
            let task = URLSession.shared.dataTask(with:callURL.url!){data, response, error in
                        
                if let networkError = NetworkError(data: data, response: response, error: error) {
                            print("APIService: error accessing server status")
                            completion(.failure(networkError))
                }
                do {
                    let status = try JSONDecoder().decode(ServerStatus.self, from: data!)
                    completion(.success(status))
                } catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                    completion(.failure(.decodingError(errorParser)))
                }
            }
            task.resume()
        }
        
        
        
        static func scooterList(withToken: String){
            let callURL = APIAccess.scooters()
            
            var request = URLRequest(url: (callURL.url)!)
            request.httpMethod = "GET"
            request.setValue(withToken, forHTTPHeaderField: "api-key")
            
            let task = URLSession.shared.dataTask(with:request){
                (data, response, error) in
                guard let data = data else{
                    print("APIService: error accessing server status")
                    return
                }
                
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    print("Server response: 3xx, 4xx or 5xx")
                    return
                }
                
                do {
                    print(data)
                    let jsonData = try JSONDecoder().decode(ScootersServer.self, from: data)
                
                    print(jsonData)
                }catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                }
                 
            }
            task.resume()
        }
        
        
    static func scooterListWithCompletion(withToken: String, completion: @escaping (Result<ScootersServer, NetworkError>) -> Void){
            let callURL = APIAccess.scooters()
            
            var request = URLRequest(url: (callURL.url)!)
            request.httpMethod = "GET"
            
            request.setValue(withToken, forHTTPHeaderField: "api-key")
            
            let task = URLSession.shared.dataTask(with:request){
                data, response, error in
                
                if let networkError = NetworkError(data: data, response: response, error: error) {
                    print("APIService: error accessing server status")
                    completion(.failure(networkError))
                }
                do {
                    let jsonData = try JSONDecoder().decode(ScootersServer.self, from: data!)
                    completion(.success(jsonData))
                } catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                    completion(.failure(.decodingError(errorParser)))
                }
            }
            task.resume()
        }
        
        //Metodos start and stop rent 
        
        static func startRent(withToken: String,uuid: String, completion: @escaping (Result<ServerRent, NetworkError>) -> Void){
            let callURL = APIAccess.scootersStartRent()
            
            var request = URLRequest(url: (callURL.url)!)
            request.httpMethod = "GET"
            
            request.setValue(withToken, forHTTPHeaderField: "api-key")
            
            let task = URLSession.shared.dataTask(with:request){
                data, response, error in
                            
                    if let networkError = NetworkError(data: data, response: response, error: error) {
                                print("APIService: error accessing server status")
                                completion(.failure(networkError))
                    }
                    do {
                        let jsonData = try JSONDecoder().decode(ServerRent.self, from: data!)
                        completion(.success(jsonData))
                    } catch let errorParser{
                        print("The data from server status is compliance with the specifications or server is not working")
                        print(errorParser)
                        completion(.failure(.decodingError(errorParser)))
                    }
            }
            task.resume()
        }
        
        static func stopRent(withToken: String,uuid: String, completion: @escaping (Result<ServerRent, NetworkError>) -> Void){
            let callURL = APIAccess.scootersStopRent()
            
            var request = URLRequest(url: (callURL.url)!)
            request.httpMethod = "GET"
            
            request.setValue(withToken, forHTTPHeaderField: "api-key")
            
            let task = URLSession.shared.dataTask(with:request){
                data, response, error in
                            
                    if let networkError = NetworkError(data: data, response: response, error: error) {
                                print("APIService: error accessing server status")
                                completion(.failure(networkError))
                    }
                    do {
                        let jsonData = try JSONDecoder().decode(ServerRent.self, from: data!)
                        completion(.success(jsonData))
                    } catch let errorParser{
                        print("The data from server status is compliance with the specifications or server is not working")
                        print(errorParser)
                        completion(.failure(.decodingError(errorParser)))
                    }
            }
            task.resume()
        }
}
