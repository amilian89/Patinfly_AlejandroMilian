//
//  ScooterServer.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 5/1/25.
//

import Foundation

struct ScootersServer: Hashable, Codable{
    var scooters: [ScooterServer]
}

struct  ScooterServer: Hashable, Codable, Equatable{
    var uuid: String
    var name: String
    var longitude: Float
    var latitude: Float
    var battery_level: Float
    var meters_use: Float
    var date_last_maintenance: String?
    var date_create: String?
    var state: String
    var vacant: Bool
}
