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
                
                VStack {
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
                    Divider()
                    Button("Condicions d'ús") {
                        showTermsView.toggle()
                    }
                    .foregroundColor(.blue)
                }
                .padding(.horizontal)
                
                Button("Entrar") {
                    loginModelView.login { success in
                        authentication.updateValidation(success: success, email: loginModelView.credentials.email)
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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Condicions d'ús")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                Text("""
        Benvingut/da a la nostra aplicació de reserves de patinets. Abans d'utilitzar els nostres serveis, si us plau llegeix atentament les següents condicions d'ús:

        1. Ús Responsable:
        - L'usuari es compromet a fer un ús responsable i respectuós amb les normes de trànsit.
        - Està prohibit l'ús dels patinets sota els efectes de l'alcohol o drogues.

        2. Registre:
        - És obligatori registrar-se amb dades reals i actualitzades.
        - L'usuari ha de ser major d'edat o disposar d'autorització dels seus tutors legals.

        3. Pagaments i Tarifes:
        - Les tarifes es cobraran segons el temps d'ús del patinet.
        - Qualsevol impagament podrà resultar en la suspensió del servei.

        4. Responsabilitat:
        - L'usuari és responsable de qualsevol dany causat al patinet durant el seu ús.
        - L'empresa no es fa responsable dels danys personals o materials que puguin ocórrer durant l'ús del servei.

        En fer ús d'aquesta aplicació, acceptes totes les condicions esmentades anteriorment.
        """)
                .padding()
            }
            
            Button("Acceptar i continuar") {
                acceptedTerms = true
                dismiss()
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



