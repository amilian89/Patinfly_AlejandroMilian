//
//  SplashScreen.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 4/1/25.
//

import SwiftUI
import SwiftData

struct SplashScreen: View {
    
    @StateObject var authentication = Authentication()
    @Environment(\.modelContext) private var modelContext
    
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
                    
                    //Codigo P2
                    //Comprobacion del status del servidor y scooters
                    APIService.checkServerStatusWithCompletion(){
                        result in
                        print (result)
                    }
                    
                    APIService.scooterListWithCompletion(withToken: APIAccess.token) { result in
                        switch result {
                        case .success(let scooters):
                            if let encodedData = try? JSONEncoder().encode(scooters),
                               let dataString = String(data: encodedData, encoding: .utf8) {
                                print("Scooter list response: \(dataString)")
                            } else {
                                print("Failed to encode scooters to JSON string")
                            }
                        case .failure(let error):
                            print("Error fetching scooters: \(error.localizedDescription)")
                        }
                    }
                    
                    APIService.checkServerStatusWithCompletion(){(result: Result<ServerStatus, NetworkError>) in
                        if ((try? result.get().status) != nil){
                            APIService.scooterList(withToken: APIAccess.token)
                            APIService.scooterListWithCompletion(withToken: APIAccess.token){(result: Result<ScootersServer, NetworkError>) in
                                do{
                                    let scootersServer: ScootersServer = try result.get()
                                    saveScootersToSwiftData(scooters: scootersServer.scooters)
                                }catch let parseError{
                                    print("JSON Error \(parseError.localizedDescription)")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func saveScootersToSwiftData(scooters: [ScooterServer]) {
        for scooterServer in scooters {
            let scooter = Scooter(
                uuid: scooterServer.uuid,
                name: scooterServer.name,
                longitude: scooterServer.longitude,
                latitude: scooterServer.latitude,
                battery_level: scooterServer.battery_level,
                meters_use: scooterServer.meters_use,
                date_last_maintenance: scooterServer.date_last_maintenance,
                date_create: scooterServer.date_create,
                state: scooterServer.state,
                vacant: scooterServer.vacant
            )
            modelContext.insert(scooter)
        }
        
        do {
            try modelContext.save()
            print("Datos guardados en SwiftData correctamente.")
        } catch {
            print("Error al guardar datos en SwiftData: \(error.localizedDescription)")
        }
    }
}

struct SplashSCreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen().previewInterfaceOrientation(.portrait)
        SplashScreen().previewInterfaceOrientation(.landscapeLeft)
    }
}
