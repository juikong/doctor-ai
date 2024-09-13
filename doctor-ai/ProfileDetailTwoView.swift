//
//  ProfileDetailTwoView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 27/07/2024.
//

import SwiftUI

struct ProfileDetailTwoView: View {
    var profile: Profile
    
    var body: some View {
        VStack {
            Spacer()
            Text(profile.detail)
                .font(.title)
            Spacer()
            Button(action: {
                print("Top up")
            }) {
                Text("Top up 10 credits")
                    .font(.title2)
                .padding()
                .frame(maxWidth: 300)
            }
            .foregroundColor(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))
            .background(Color(.lightGray))
            .cornerRadius(30)
            .padding()
        }
        .navigationTitle(profile.linkname)
    }
}

#Preview {
    ProfileDetailTwoView(profile: Profile(linkname: "My Usages", detail: "15 Credits remaining"))
}
