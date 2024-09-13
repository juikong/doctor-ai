//
//  OnboardingItemView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI

struct OnboardingIntroView: View {
    var body: some View {
        VStack {
            Image(systemName: "medical.thermometer")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            Text("Title 1")
                .font(.title)
                .padding(.top, 10)
            Text("Description 1.")
                .font(.body)
                .padding(.top, 2)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    OnboardingIntroView()
}
