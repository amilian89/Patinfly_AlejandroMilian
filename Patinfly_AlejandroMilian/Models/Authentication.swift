//
//  Authentication.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 3/1/25.
//

import Foundation
import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated: Bool = false
    
    func updateValidation(success: Bool){
        withAnimation{
            isValidated = success
        }
    }
}
