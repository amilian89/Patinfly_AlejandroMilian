//
//  LoginView.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 3/1/25.
//

import SwiftUI

struct LoginView: View {
    @State var labelText: String = "No selected"
    
    @StateObject private var loginModelView = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            // Logo or Image at the top
            Image(systemName: "scooter")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 60)
                .foregroundColor(.blue)
            
            Text("Welcome Back")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("Sign in to continue")
                .font(.subheadline)
                .foregroundColor(.gray)
            

            VStack(spacing: 15) {
                TextField("Adreça de correu", text: $loginModelView.credentials.email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                
                SecureField("Contrassenya", text: $loginModelView.credentials.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                if loginModelView.showProgressView {
                    ProgressView()
                }
                
                Button("Sign in") {
                    loginModelView.login { success in
                        labelText = "Selected"
                    }
                }
                .disabled(loginModelView.loginDisable)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                TextField("", text: $labelText)
                    .padding(.horizontal, 80)
                    .padding(.vertical, 20)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(loginModelView.showProgressView)
            }
        }
        .padding(.horizontal, 60)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

