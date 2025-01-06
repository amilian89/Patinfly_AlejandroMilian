//
//  Patinfly_AlejandroMilianApp.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 3/1/25.
//

import SwiftUI
import SwiftData

@main
struct Patinfly_AlejandroMilianApp: App {
    
    @StateObject var authentication = Authentication()
    
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                MenuTabView().environmentObject(authentication)
            }
            else{
                SplashScreen().environmentObject(authentication)
                //LoginView().environmentObject(authentication)
            }
        }
        .modelContainer(for: Scooter.self)
    }
}
