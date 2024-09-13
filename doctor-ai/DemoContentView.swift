//
//  DemoContentView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 26/07/2024.
//

import SwiftUI

struct DemoContentView: View {
    var body: some View {
        TabView {
            DemoReportView()
            .tabItem {
                Label("Reports",
                      systemImage: "doc.text")
            }
            
            DemoProfileView()
            .tabItem {
                Label("Profile",
                      systemImage: "person.crop.circle")
            }
        }
    }
}

#Preview {
    DemoContentView()
}
