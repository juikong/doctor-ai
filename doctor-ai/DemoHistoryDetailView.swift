//
//  DemoHistoryDetailView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 27/07/2024.
//

import SwiftUI

struct DemoHistoryDetailView: View {
    var batch: Int16
    @StateObject private var demomatchModel = DemomatchModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(demomatchModel.demomatch, id: \.self) { matched in
                    HStack {
                        Text(matched.sub ?? "No name")
                        Spacer()
                        Text(matched.result ?? "No result")
                    }
                }
            }
            .navigationTitle("History Detail Report")
        }
        .onAppear {
            demomatchModel.fetchDemomatchBatch(withBatch: batch)
        }
    }
}

#Preview {
    DemoHistoryDetailView(batch: 1)
}
