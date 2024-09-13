//
//  ReportDetailView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI
import Charts

struct ReportDetailView: View {
    var sub: String
    @State private var dataLoaded = false
    @StateObject private var itemModel = ItemModel()
    @StateObject private var testnameModel = TestnameModel()
    @StateObject private var testmatchModel = TestmatchModel()
    
    var body: some View {
        VStack {
            if dataLoaded {
                Chart {
                    if testmatchModel.testmatch.count == 1 {
                        let testmatch1 = testmatchModel.testmatch[0]
                        BarMark(x: .value("Result", "Last"),
                                y: .value(sub, Float(testmatch1.result ?? "0")!))
                        .foregroundStyle(.blue)
                    }

                    if testmatchModel.testmatch.count == 2 {
                        let testmatch1 = testmatchModel.testmatch[0]
                        BarMark(x: .value("Result", "Last 2"),
                                y: .value(sub, Float(testmatch1.result ?? "0")!))
                        .foregroundStyle(.blue)
                        
                        let testmatch2 = testmatchModel.testmatch[1]
                        BarMark(x: .value("Result", "Last"),
                                y: .value(sub, Float(testmatch2.result ?? "0")!))
                        .foregroundStyle(.blue)
                    }
                    
                    if testmatchModel.testmatch.count == 3 {
                        let testmatch1 = testmatchModel.testmatch[0]
                        BarMark(x: .value("Result", "Last 3"),
                                y: .value(sub, Float(testmatch1.result ?? "0")!))
                        .foregroundStyle(.blue)
                        
                        let testmatch2 = testmatchModel.testmatch[1]
                        BarMark(x: .value("Result", "Last 2"),
                                y: .value(sub, Float(testmatch2.result ?? "0")!))
                        .foregroundStyle(.blue)
                        
                        let testmatch3 = testmatchModel.testmatch[1]
                        BarMark(x: .value("Result", "Last"),
                                y: .value(sub, Float(testmatch3.result ?? "0")!))
                        .foregroundStyle(.blue)
                    }
                                        
                    if (testnameModel.maxvalue != "-") {
                        RuleMark(y: .value("Max", Float(testnameModel.maxvalue) ?? 0))
                            .annotation(position: .bottom,
                                        alignment: .bottomLeading) {
                                Text(testnameModel.maxstring)
                                    .foregroundColor(.red)
                            }
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .foregroundColor(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))
        .padding()
        .navigationTitle(sub)
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
        .onAppear {
            itemModel.fetchLastBatch()
            testnameModel.fetchMaxvalue(withSub: sub)
            testmatchModel.fetchTestmatchSubLastBatches(withSub: sub, MaxBatch: Int16(itemModel.lastbatch) ?? 1)
        }
        .onChange(of: testmatchModel.testmatch) {
            if !testmatchModel.testmatch.isEmpty {
                dataLoaded = true
            }
        }
    }
}

//#Preview {
//    ReportDetailView()
//}
