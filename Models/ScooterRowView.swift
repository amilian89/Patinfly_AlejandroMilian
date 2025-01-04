//
//  ScooterRowView.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 4/1/25.
//

import Foundation
import SwiftUI

struct ScooterRowView: View {
    let name: String
    let uuid: String
    let distance: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .bold()
                    .foregroundColor(.black)
                    .font(.body)
                
                HStack {
                    Text(uuid)  // Aquí se mostrará el estado en horizontal
                        .font(.body)
                    
                    Spacer()
                    
                    HStack {
                        Text("km:")
                        Text(distance)
                    }
                    .frame(width: 100, alignment: .trailing)
                }
            }
        }
        .padding(.vertical, 10)
    }
}



