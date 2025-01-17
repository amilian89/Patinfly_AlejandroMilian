//
//  ScooterDetailView.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 5/1/25.
//

import SwiftUI
import MapKit

struct ScooterDetailView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.116444, longitude: 1.124695), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var scooter: Scooter
    
    // Alertas de confirmación para iniciar/finalizar reserva
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        let places = [Place(name: "Position 1", latitude: 31.21, longitude: 120.50)]
        
        VStack(spacing: 20) {
            
            // Mapa práctica 2
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: places) { place in
                MapMarker(coordinate: place.coordinate)
            }
            .frame(height: 300)
            .cornerRadius(15)
            
            // Detalle del Scooter
            VStack(alignment: .leading, spacing: 15) {
                
                HStack {
                    Text(scooter.name)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    if scooter.battery_level == 100 {
                        Image(systemName: "battery.100")
                            .font(.system(size: 25))
                            .foregroundColor(.green)
                    } else if scooter.battery_level > 50 {
                        Image(systemName: "battery.75")
                            .font(.system(size: 25))
                            .foregroundColor(.green)
                    } else if scooter.battery_level == 50 {
                        Image(systemName: "battery.50")
                            .font(.system(size: 25))
                            .foregroundColor(.orange)
                    } else {
                        Image(systemName: "battery.25")
                            .font(.system(size: 25))
                            .foregroundColor(.red)
                    }
                    
                    let formattedFloat = String(format: "%.1f", scooter.battery_level)
                    Text("\(formattedFloat)%")
                        .font(.headline)
                }
                .padding(.horizontal)
                
                HStack {
                    if scooter.state == "ACTIVE" {
                        Image(systemName: "scooter")
                            .font(.system(size: 25))
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "scooter")
                            .font(.system(size: 25))
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Text("10 m")
                        .font(.title3)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                
            }
            
            Spacer()
            
            // Botones para alquilar práctica 2
            HStack {
                Button(action: {
                    startRent(uuid: scooter.uuid)
                }) {
                    Text("Iniciar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirmación"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                Button(action: {
                    stopRent(uuid: scooter.uuid)
                }) {
                    Text("Finalitzar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirmación"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
        .navigationTitle("Scooter Detail")
        .onAppear() {
            LocationManager.shared.getUserLocation { location in
                DispatchQueue.main.async {
                    region.center.latitude = location.coordinate.latitude
                    region.center.longitude = location.coordinate.longitude
                }
            }
        }
       
    }
    
    // Iniciar alquiler con pop-up
    func startRent(uuid: String) {
        APIService.startRent(withToken: APIAccess.token, uuid: uuid) { result in
            print(result)
            DispatchQueue.main.async {
                switch result {
                case .success(let serverResponse):
                    if serverResponse.code == 200 {
                        alertMessage = "Lloguer iniciat amb èxit"
                    } else if serverResponse.code == 405 {
                        alertMessage = "Aquest patinet ja està reservat"
                    } else {
                        alertMessage = "Error inesperat: \(serverResponse.msg)"
                    }
                case .failure:
                    alertMessage = "Error al inicialitzar el lloguer"
                }
                showAlert = true
            }
        }
    }
    
    // Finalizar alquiler con pop-up
    func stopRent(uuid: String) {
        APIService.stopRent(withToken: APIAccess.token, uuid: uuid) { result in
            print(result)
            DispatchQueue.main.async {
                switch result {
                case .success(let serverResponse):
                    if serverResponse.code == 200 {
                        alertMessage = "Lloguer finalitzat amb èxit"
                    } else if serverResponse.code == 405 {
                        alertMessage = "Aquest patinet no està reservat"
                    } else {
                        alertMessage = "Error inesperat: \(serverResponse.msg)"
                    }
                case .failure:
                    alertMessage = "Error al finalitzar el lloguer"
                }
                showAlert = true
            }
        }
    }


}


