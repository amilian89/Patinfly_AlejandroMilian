//
//  ContentView.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 3/1/25.
//

import SwiftUI
import SwiftData

struct ScooterListView: View {
    
    @Query private var scooters: [Scooter]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(scooters) { scooter in
                        NavigationLink(destination: ScooterDetailView(scooter: scooter)){
                            ScooterRowView(name: scooter.name, uuid: scooter.state, distance: "10", battery_level: scooter.battery_level)
                        }
                    }
                }
            }
            .navigationTitle("Scooters")
        }
    }
}


struct ScooterListView_Previews: PreviewProvider {
    static var previews: some View {
        ScooterListView().modelContainer(for: Scooter.self)
    }
}
