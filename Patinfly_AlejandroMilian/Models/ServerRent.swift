//
//  ServerRent.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 5/1/25.
//

import Foundation

struct RentStart: Codable{
    let uuid: String
    let date_start: String
    let date_stop: String?
}


struct ServerRent: Codable {
    let code:Int
    let msg: String
    let rent: RentStart
    let timestamp: String
    let version: Int?
}
