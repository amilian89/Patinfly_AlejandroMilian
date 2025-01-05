//
//  ScooterDetailView.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 5/1/25.
//

import SwiftUI

struct ScooterDetailView: View {
    var scooter: Scooter
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Mapa (Preparado para P2)
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .cornerRadius(15)
                
                Text("Mapa aquí")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
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
            
            // Botón para alquilar (TODO para P2)
            
        }
        .navigationTitle("Scooter Detail")
    }
}
