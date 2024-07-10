//
//  HomeDetailView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI

struct HomeDetailView: View {
    var sub: String
    var result: String
    
    var body: some View {
        HStack {
            Text(sub)
                .font(.subheadline)
            Spacer()
            Text(result)
                .font(.title3)
        }
        .foregroundColor(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))
        .padding()
        .navigationTitle(sub)
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#Preview {
    HomeDetailView(sub: "Haemoglobin", result: "14.3")
}
