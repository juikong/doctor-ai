//
//  ProfileItemView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 08/07/2024.
//
//  Deprecated replaced by NavigationStack

import SwiftUI

struct ProfileItemView: View {
    let profileLink: String
    @State private var navigationPath = NavigationPath()

    var body: some View {
        VStack {
            HStack {
                Text(profileLink)
                    .font(.body)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.systemGray))
                    .font(.system(size: 20))
            }
            .padding()
            Divider()
        }
    }
}

#Preview {
    ProfileItemView(profileLink: "My Plan")
}
