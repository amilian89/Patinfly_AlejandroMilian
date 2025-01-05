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
    let battery_level: Float
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .bold()
                    .foregroundColor(.black)
                    .font(.body)
                
                HStack {
                    if uuid == "ACTIVE"{
                        Image(systemName: "scooter").font(.system(size: 25.0)).foregroundColor(.green)
                    }
                    else{
                        Image(systemName: "scooter").font(.system(size: 25.0)).foregroundColor(.red)
                    }
                    
                    HStack{
                        VStack{
                            if (battery_level == 100 ){
                                Image(systemName: "battery.100").font(.system(size: 25.0)).foregroundColor(.green)
                            }
                            else if (battery_level < 100 && battery_level > 50){
                                Image(systemName: "battery.75").font(.system(size: 25.0)).foregroundColor(.green)
                            }
                            else if (battery_level == 50){
                                Image(systemName: "battery.50").font(.system(size: 25.0)).foregroundColor(.orange)
                            }
                            else{
                                Image(systemName: "battery.25").font(.system(size: 25.0)).foregroundColor(.red)
                            }
                            Spacer()
                            Text(distance + "  m")
                        }
                    }.frame(width: 290, alignment: .trailing)
                }
            }
        }
    }
}



