//
//  DemoProfileDetailView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 27/07/2024.
//

import SwiftUI

struct DemoProfileDetailView: View {
    var profile: Profile
    @StateObject private var itemModel = ItemModel()
    
    var body: some View {
        VStack {
            Button(action: {
                itemModel.updateItem(withId: 4, newValue: 0)
            }) {
                VStack {
                    Text(profile.detail)
                        .font(.title)
                    Text("$1.99 Yearly")
                        .font(.title2)
                }
                .padding()
                .frame(maxWidth: 300)
            }
            .foregroundColor(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))
            .background(Color(.lightGray))
            .cornerRadius(30)
        }
        .navigationTitle(profile.linkname)
    }
}

#Preview {
    DemoProfileDetailView(profile: Profile(linkname: "Upgrade My Plan", detail: "Subscribe to Doctor AI"))
}
