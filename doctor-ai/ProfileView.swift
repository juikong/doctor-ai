//
//  ProfileView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 08/07/2024.
//

import SwiftUI

struct ProfileView: View {
    @State private var plusUser: Bool = false
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
                        Text("My Plan")
                            .font(.body)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.systemGray))
                            .font(.system(size: 20))
                    }
                    .contentShape(Rectangle())
                    //.listRowBackground(Color.white)
                    .onTapGesture {
                        navigationPath.append(Profile(linkname: "My Plan", detail: "Doctor AI Pro"))
                    }
                    HStack {
                        Text("My Usages")
                            .font(.body)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.systemGray))
                            .font(.system(size: 20))
                    }
                    .contentShape(Rectangle())
                    //.listRowBackground(Color.white)
                    .onTapGesture {
                        navigationPath.append(Profile(linkname: "My Usages", detail: "15 Credits remaining"))
                    }
                    HStack {
                        Text("Add-on Medical Report Name")
                            .font(.body)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.systemGray))
                            .font(.system(size: 20))
                    }
                    .contentShape(Rectangle())
                    //.listRowBackground(Color.white)
                    .onTapGesture {
                        navigationPath.append(Profile(linkname: "Add-on Medical Report Name", detail: ""))
                    }
                }
#if os(iOS)
                .listStyle(InsetGroupedListStyle())
#else
                .listStyle(InsetListStyle())
#endif
            }
            .navigationDestination(for: Profile.self) { profile in
                switch profile.linkname {
                case "My Plan":
                    ProfileDetailOneView(profile: profile)
                case "My Usages":
                    ProfileDetailTwoView(profile: profile)
                case "Add-on Medical Report Name":
                    ProfileDetailThreeView(profile: profile)
                default:
                    ProfileDetailOneView(profile: profile)
                }
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
    }
}

#Preview {
    ProfileView()
}
