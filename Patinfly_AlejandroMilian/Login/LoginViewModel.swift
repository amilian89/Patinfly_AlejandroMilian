//
//  LoginViewModel.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 3/1/25.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    
    var loginDisable: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(completition: @escaping(Bool) -> Void){
            showProgressView = true
            APIService.shared.login(credentials: credentials){[unowned self](result:Result<Bool, Authentication.AuthenticationError>) in
                showProgressView = false
                switch result{
                    case .success:
                        completition(true)
                    case .failure(let authError):
                        credentials = Credentials()
                        completition(false)
                }
            }
        }
    }
