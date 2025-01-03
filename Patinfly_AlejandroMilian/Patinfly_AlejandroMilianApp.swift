//
//  Patinfly_AlejandroMilianApp.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 3/1/25.
//

import SwiftUI

@main
struct Patinfly_AlejandroMilianApp: App {
    
    @StateObject var authentication = Authentication()
    
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                ContentView().environmentObject(authentication)
            }
            else{
                LoginView().environmentObject(authentication)
            }
        }
    }
}
