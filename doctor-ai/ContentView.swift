//
//  ContentView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
            .tabItem {
                Label("Home",
                      systemImage: "house")
            }

            ReportView()
            .tabItem {
                Label("Reports",
                      systemImage: "doc.text")
            }
            
            ProfileView()
            .tabItem {
                Label("Profile",
                      systemImage: "person.crop.circle")
            }
        }
    }
}

#Preview {
    ContentView()
}
