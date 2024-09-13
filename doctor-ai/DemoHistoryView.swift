//
//  DemoHistoryView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 27/07/2024.
//

import SwiftUI

struct DemoHistoryView: View {
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: DemoHistoryDetailView(batch: 1), label: {
                    Text("1")
                        .font(.title2)
                })
                NavigationLink(destination: DemoHistoryDetailView(batch: 2), label: {
                    Text("2")
                        .font(.title2)
                })
                NavigationLink(destination: DemoHistoryDetailView(batch: 3), label: {
                    Text("3")
                        .font(.title2)
                })
            }
            .navigationTitle("History Report")
        }
    }
}

#Preview {
    DemoHistoryView()
}
