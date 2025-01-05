//
//  ProfileView.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 5/1/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        VStack(spacing: 30) {
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .padding(.top, 50)
            
            VStack(alignment: .leading) {
                Text("Correu electrònic")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(authentication.userEmail ?? "Correu electrònic no disponible")
                    .font(.body)
                    .bold()
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Perfil")
    }
}
