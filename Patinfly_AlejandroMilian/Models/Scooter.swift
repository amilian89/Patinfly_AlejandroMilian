//
//  Scooter.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 4/1/25.
//

import SwiftData

@Model
class Scooter {
    @Attribute(.unique) var uuid: String
    var name: String
    var longitude: Float
    var latitude: Float
    var battery_level: Float
    var meters_use: Float
    var date_last_maintenance: String?
    var date_create: String?
    var state: String
    var vacant: Bool
    
    init(uuid: String, name: String, longitude: Float, latitude: Float, battery_level: Float, meters_use: Float, date_last_maintenance: String?, date_create: String?, state: String, vacant: Bool) {
        self.uuid = uuid
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.battery_level = battery_level
        self.meters_use = meters_use
        self.date_last_maintenance = date_last_maintenance
        self.date_create = date_create
        self.state = state
        self.vacant = vacant
    }
}


