//
//  DemoReportDetailView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 26/07/2024.
//

import SwiftUI
import Charts

struct DemoReportDetailView: View {
    var sub: String
    @State private var dataLoaded = false
    @StateObject private var testnameModel = TestnameModel()
    @StateObject private var demomatchModel = DemomatchModel()
    
    var body: some View {
        VStack {
            if dataLoaded {
                Chart {
                    let demomatch1 = demomatchModel.demomatch[0]
                    BarMark(x: .value("Result", "Last 3"),
                            y: .value(sub, Float(demomatch1.result ?? "0")!))
                    .foregroundStyle(.blue)
                    
                    let demomatch2 = demomatchModel.demomatch[1]
                    BarMark(x: .value("Result", "Last 2"),
                            y: .value(sub, Float(demomatch2.result ?? "0")!))
                    .foregroundStyle(.blue)
                    
                    let demomatch3 = demomatchModel.demomatch[2]
                    BarMark(x: .value("Result", "Last"),
                            y: .value(sub, Float(demomatch3.result ?? "0")!))
                    .foregroundStyle(.blue)
                                        
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
            testnameModel.fetchMaxvalue(withSub: sub)
            demomatchModel.fetchDemomatchSubLastBatches(withSub: sub, MaxBatch: 3)
        }
        .onChange(of: demomatchModel.demomatch) {
            if !demomatchModel.demomatch.isEmpty {
                dataLoaded = true
            }
        }
    }
}

//#Preview {
//    DemoReportDetailView()
//}
