//
//  OnboardingItemView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI

struct OnboardingItemView: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            Text(title)
                .font(.title)
                .padding(.top, 10)
            Text(description)
                .font(.body)
                .padding(.top, 2)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    OnboardingItemView(imageName: "medical.thermometer", title: "Title", description: "Description")
}
