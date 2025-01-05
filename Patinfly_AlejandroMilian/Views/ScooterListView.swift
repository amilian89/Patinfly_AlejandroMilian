//
//  ContentView.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 3/1/25.
//

import SwiftUI

struct ScooterListView: View {
    @State var scooters: Scooters = Scooters(scooters: [])
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(scooters.scooters) { scooter in
                        NavigationLink(destination: ScooterDetailView(scooter: scooter)){
                            ScooterRowView(name: scooter.name, uuid: scooter.state, distance: "10", battery_level: scooter.battery_level)
                        }
                    }
                }
            }
            .navigationTitle("Scooters")
        }
        .onAppear {
            if let url = Bundle.main.url(forResource: "scooters", withExtension: "json") {
                do {
                    let jsonData = try Data(contentsOf: url)
                    print(jsonData)
                    let decoder = JSONDecoder()
                    print(try decoder.decode(Scooters.self, from: jsonData))
                    scooters = try decoder.decode(Scooters.self, from: jsonData)
                } catch {
                    print(error)
                }
            }
        }
    }
}


struct ScooterListView_Previews: PreviewProvider {
    static var previews: some View {
        ScooterListView()
    }
}
