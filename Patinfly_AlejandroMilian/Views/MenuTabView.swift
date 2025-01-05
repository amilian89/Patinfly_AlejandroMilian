//
//  MenuTabView.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 5/1/25.
//

import SwiftUI

struct MenuTabView: View {
    @State private var selectedTab = 1
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        TabView(selection: $selectedTab){
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }.tag(0)
            
            ScooterListView()
                .tabItem {
                    Label("Scooters", systemImage: "scooter")
                }.tag(1)
            
            RentListView()
                .tabItem {
                    Label("Historial", systemImage: "book")
                }.tag(2)
        }
    }
}

#Preview {
    MenuTabView()
}
