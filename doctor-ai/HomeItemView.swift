//
//  HomeItemView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//
//  Deprecated replaced by NavigationStack

import SwiftUI

struct HomeItemView: View {
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
    }
}

#Preview {
    HomeItemView(sub: "Haemoglobin", result: "14.3")
}
