//
//  LoginView.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 3/1/25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginModelView = LoginViewModel()
    @State private var acceptedTerms = false
    @State private var showTermsView = false
    
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "scooter")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 60)
                .foregroundColor(.blue)
            
            Text("Patinfly App")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("Inicia sessió per a continuar")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            VStack(spacing: 15) {
                TextField("Adreça de correu", text: $loginModelView.credentials.email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .autocapitalization(.none)
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
                
                HStack {
                    Button(action: {
                        acceptedTerms.toggle()
                    }) {
                        HStack {
                            Image(systemName: acceptedTerms ? "checkmark.square.fill" : "square")
                                .foregroundColor(acceptedTerms ? .green : .gray)
                            Text("Accepto les condicions d'ús")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button("Condicions d'ús") {
                        showTermsView.toggle()
                    }
                    .foregroundColor(.blue)
                }
                .padding(.horizontal)
                
                Button("Sign in") {
                    loginModelView.login { success in
                        authentication.updateValidation(success: success)
                    }
                }
                .disabled(loginModelView.loginDisable || !acceptedTerms)
                .frame(maxWidth: .infinity)
                .padding()
                .background(acceptedTerms ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .alert(item: $loginModelView.error) { error in
                    Alert(title: Text("Error validació"), message: Text(error.localizedDescription))
                }
            }
        }
        .padding(.horizontal, 60)
        .sheet(isPresented: $showTermsView) {
            TermsView(acceptedTerms: $acceptedTerms)
        }
    }
}

struct TermsView: View {
    @Binding var acceptedTerms: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Condicions d'ús")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                Text("Aquí van les condicions d'ús de Patinfly. Aquestes són les normes i directrius...")
                    .padding()
            }
            
            Button("Acceptar i continuar") {
                acceptedTerms = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(Authentication())
    }
}



