//
//  HistoryView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 24/07/2024.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var testbatchModel = TestbatchModel()
    @StateObject private var testmatchModel = TestmatchModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(testbatchModel.testbatch, id: \.self) { history in
                    NavigationLink(destination: HistoryDetailView(batch: history.batch), label: {
                        Text(history.time?.description ?? "No time")
                    })
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("History Report")
#if os(iOS)
            .navigationBarItems(trailing: EditButton()
                )
#endif
        }
        .onAppear {
            testbatchModel.fetchTestbatch()
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let batch = testbatchModel.testbatch[index].batch
            testbatchModel.deleteTestbatch(withBatch: batch)
            testmatchModel.deleteTestmatch(withBatch: batch)
        }
    }
}

#Preview {
    HistoryView()
}
