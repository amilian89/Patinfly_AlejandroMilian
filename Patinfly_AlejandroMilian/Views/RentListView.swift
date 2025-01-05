//
//  RentListView.swift
//  Patinfly_AlejandroMilian
//
//  Created by Alejandro Milian Lago on 5/1/25.
//

import SwiftUI

struct RentListView: View {
    var body: some View {
        VStack{
            Text("Historial de Lloguers")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 20)
            
            Text("Historial de lloguers")
            Spacer()
        }
    }
}

#Preview {
    RentListView()
}
