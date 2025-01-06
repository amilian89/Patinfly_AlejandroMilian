//
//  Status.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 5/1/25.
//

import Foundation

struct Status: Codable {
    let id:Int = 1
    let version: Int
    let build: Int
    let update: String
    let name: String
}

struct ServerStatus: Codable{
    let id:Int = 1
    let status: Status
}
