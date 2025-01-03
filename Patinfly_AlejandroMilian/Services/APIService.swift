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
               completition: @escaping (Result<Bool, APIError>) -> Void){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            if self.validUser(credentials: credentials){
                completition(.success(true))
            }
            else{
                completition(.failure(APIError.error))
            }
        }
    }
}
