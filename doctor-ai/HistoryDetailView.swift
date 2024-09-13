//
//  HistoryDetailView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 24/07/2024.
//

import SwiftUI
import Charts

struct HistoryDetailView: View {
    var batch: Int16
    @StateObject private var testmatchModel = TestmatchModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(testmatchModel.testmatch, id: \.self) { matched in
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
            testmatchModel.fetchTestmatchBatch(withBatch: batch)
        }
    }
}

#Preview {
    HistoryDetailView(batch: 1)
}
