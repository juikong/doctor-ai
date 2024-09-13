//
//  DemoProfileView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 27/07/2024.
//

import SwiftUI

struct DemoProfileView: View {
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("User Profile")
                    .font(.largeTitle).foregroundColor(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))
                    .padding(.top, 10)
                Spacer()
                List {
                    HStack {
                        Text("Upgrade My Plan")
                            .font(.body)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.systemGray))
                            .font(.system(size: 20))
                    }
                    .contentShape(Rectangle())
                    //.listRowBackground(Color.white)
                    .onTapGesture {
                        navigationPath.append(Profile(linkname: "Upgrade My Plan", detail: "Subscribe to Doctor AI"))
                    }
                }
#if os(iOS)
                .listStyle(InsetGroupedListStyle())
#else
                .listStyle(InsetListStyle())
#endif
            }
            .navigationDestination(for: Profile.self) { profile in
                DemoProfileDetailView(profile: profile)
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
    }
}

#Preview {
    DemoProfileView()
}
