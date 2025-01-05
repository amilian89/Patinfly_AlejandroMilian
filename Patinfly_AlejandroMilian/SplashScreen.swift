//
//  SplashScreen.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 4/1/25.
//

import SwiftUI

struct SplashScreen: View {
    
    @StateObject var authentication = Authentication()
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if self.isActive {
            if authentication.isValidated {
                MenuTabView()
            } else {
                LoginView()
            }
        } else {
            VStack {
                VStack {
                    Image(uiImage: UIImage(named: "Logo") ?? UIImage()).scaleEffect(0.8)
                    Text("Patinfly").font(.title)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashSCreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen().previewInterfaceOrientation(.portrait)
        SplashScreen().previewInterfaceOrientation(.landscapeLeft)
    }
}
