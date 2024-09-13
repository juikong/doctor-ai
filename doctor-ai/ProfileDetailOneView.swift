//
//  ProfileDetailView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 08/07/2024.
//

import SwiftUI

struct ProfileDetailOneView: View {
    var profile: Profile
    
    var body: some View {
        HStack {
            Image(systemName: "star.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            Text(profile.detail)
                .font(.title)
        }
        .navigationTitle(profile.linkname)
    }
}

#Preview {
    ProfileDetailOneView(profile: Profile(linkname: "My Plan", detail: "Doctor AI Pro"))
}
