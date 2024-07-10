//
//  ProfileDetailView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 08/07/2024.
//

import SwiftUI

struct ProfileDetailView: View {
    var profile: Profile
    
    var body: some View {
        Text(profile.linkname)
    }
}

#Preview {
    ProfileDetailView(profile: Profile(linkname: "My Plan"))
}
